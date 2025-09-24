Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users

  resources :posts do
    resources :comments, only: [ :create, :edit, :update, :destroy ]
  end

  resources :comments do
    collection do
      post :upload_image
    end
  end

  root "posts#index"
end
