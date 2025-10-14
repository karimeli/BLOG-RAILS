Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users

  resources :posts do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end

  # Aquí se define la nueva página de inicio
  root "home#index"

  # Ruta para el login
  get "login", to: "devise/sessions#new"
end
