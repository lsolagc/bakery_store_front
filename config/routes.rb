Rails.application.routes.draw do
  get 'welcome/index'
  resources :product_instances, only: [:destroy] do
    member do
      get 'set_quantity'
      get 'set_combination'
    end
  end
  resources :shopping_carts, except: [:new, :create, :destroy] do
    member do
      post  'finalize_order'
      get   'cancel_order'
    end
  end
  resources :products, only: [:show, :index] do
    member do
      get 'add_to_cart'
    end
  end
  # resources :sizes
  # resources :kinds
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {:registrations => "registrations"}
  ActiveAdmin.routes(self)

  root to: "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
