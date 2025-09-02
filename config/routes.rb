Rails.application.routes.draw do
  # Rutas para posts con comentarios anidados
  resources :posts do
    resources :comments, only: [:create]  # Solo necesitamos la acción create para los comentarios
  end

  # Página de inicio
  root 'home#index'
end
