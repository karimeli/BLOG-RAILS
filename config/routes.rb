Rails.application.routes.draw do
  # Ruta de posts (CRUD completo)
  resources :posts

  # Ruta de la página de inicio
  get 'home/index'

  # Página principal
  root 'home#index'
end
