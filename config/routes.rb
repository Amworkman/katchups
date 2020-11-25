Rails.application.routes.draw do
  resources :restaurants
  resources :katchups
  resources :relationships
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
