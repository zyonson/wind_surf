Rails.application.routes.draw do
  root "users#new"
  get '/signup', to: "users#new"
  resources :users do
    collection do
      get :search
    end
  end
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :stores do
    collection do
      post :search
    end
  end
end
