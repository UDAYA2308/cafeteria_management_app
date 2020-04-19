Rails.application.routes.draw do
  resources :carts
  resources :menu_items
  resources :menus
  resources :users
  resources :order_items
  resources :orders
  get "/", to: "sessions#new"
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
