Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {registrations: "registrations"}

  resources :posts do
    resources :comments
  end

  resources :comments, only: %i(create destroy)

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: %i(create destroy)
end
