Rails.application.routes.draw do
  resources :restaurants
  resources :katchups
  resources :relationships
  resources :users

  post "/login", to:"users#login"
  get "/auto_login", to: "users#auto_login"
  get "/friends/pending_requests", to: "users#pending_requests"
  get "/friends/requests", to: "users#friend_requests"
  get "/friends", to: "users#friends"
  get "/places_key", to: "places_key#index"
  delete "/delete_pending", to: "relationships#delete_pending"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
