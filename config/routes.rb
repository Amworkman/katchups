Rails.application.routes.draw do
  resources :restaurants
  resources :katchups
  resources :relationships
  resources :users

  post "/login", to:"users#login"
  get "/auto_login", to: "users#auto_login"
  get "/pending_friends", to: "users#pending_friends"
  get "/friends", to: "users#friends"
  delete "/delete_pending", to: "relationships#delete_pending"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
