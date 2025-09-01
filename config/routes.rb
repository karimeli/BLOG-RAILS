Rails.application.routes.draw do
  resources :posts
  get 'home/index'
  root 'home#index'  # Esta línea hace que home#index sea la página principal
end