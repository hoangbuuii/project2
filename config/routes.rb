Rails.application.routes.draw do 
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  match "/users", to: "users#index", via: "get"
  match "/users/:id", to: "users#show", via: "get"

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
