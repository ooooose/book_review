Rails.application.routes.draw do
  get '/home', to: 'top#index'
  root 'top#index'
  
  get '/search', to: 'books#serch'
  delete '/search', to: 'books#reset'
  get 'books/index', to: 'books#index'
  post 'books/new', to: 'books#create'
  
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :reviews
  resources :books
  resources :sessions
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
