Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :relationships, only: %i(create destroy)

  resources :microposts do
    resources :comments
  end

  resources :comments, only: %i(create destroy)
  
  resources :users do
    member do
      get :following, :followers
    end
  end
end
