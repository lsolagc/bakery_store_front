Rails.application.routes.draw do
  get 'welcome/index'
  resources :product_instances, only: [:destroy] do
    member do
      get 'set_quantity'
      get 'set_combination'
    end
  end
  resources :shopping_carts
  resources :products do
    member do
      get 'add_to_cart'
    end
  end
  resources :sizes
  resources :kinds
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root to: "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
