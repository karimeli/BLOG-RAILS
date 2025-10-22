Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users

  # Define el root de la aplicación basado en la autenticación
  devise_scope :user do
    authenticated :user do
      # Si el usuario está logueado, el root es la lista de posts
      root "posts#index", as: :authenticated_root
    end

    unauthenticated do
      # Si el usuario no está logueado, el root es la página de login
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :posts do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end

  # La ruta 'home#index' original ya no es el root, pero la mantenemos
  # por si quieres acceder a ella directamente (ej. /home)
  get "home", to: "home#index"

  # Ruta para el login (alias)
  get "login", to: "devise/sessions#new"
end
