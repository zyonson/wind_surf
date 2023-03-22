Rails.application.routes.draw do
  root "stores#main"
  get '/signup', to: "users#new"
  resources :users do
    collection do
      get :search
      get :favorites
    end
  end
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :stores do
    collection do
      get :searchstore
      post :search
      get :main
    end
  end

  resources :stores do
    resources :favorites, only: [:create, :destroy]
  end

  resources :microposts, only: [:create, :destroy]
end
