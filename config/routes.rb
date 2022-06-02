Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create]
      resources :subscriptions, only: [:index, :create, :update]
    end
  end
end
