Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [ :create, :destroy ]  # Solo 'create' y 'destroy' para comentarios
  end

  root "home#index"  # Página principal
end
