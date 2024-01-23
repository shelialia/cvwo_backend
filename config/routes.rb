Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :posts, only: [:index, :show, :create, :update, :destroy]do
        resources :comments
      end
    end
  end
end