Rails.application.routes.draw do
  get 'welcome/index'
  resources :shopping_carts
  resources :products
  resources :sizes
  resources :kinds
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root to: "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
