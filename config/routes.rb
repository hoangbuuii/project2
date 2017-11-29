Rails.application.routes.draw do 
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  devise_for :users, controllers:{
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  match "/users", to: "users#index", via: "get"
  match "/users/:id", to: "users#show", via: "get"
  
  resources :relationships, only: %i(create destroy)

  resources :posts do
    resources :comments
  end
  get "tags/:tag", to: "posts#index", as: "tag"
  resources :comments, only: %i(create destroy)

  resources :users do
    member do
      get :following, :followers
    end
  end
end
