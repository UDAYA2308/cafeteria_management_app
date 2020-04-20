Rails.application.routes.draw do
  resources :carts
  resources :menu_items
  resources :menus
  resources :users
  resources :order_items
  resources :orders
  get "/", to: "sessions#new"
  get "/yourorder", to: "orders#your_orders"
  get "/sales_report", to: "orders#report"
  post "viewcart", to: "orders#view"
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  get "/home", to: "home#index"
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
