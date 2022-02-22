Rails.application.routes.draw do
  
  get '/home', to: 'top#index'
  root 'top#index'
  
  get 'posts/index', to: 'posts#index'
  
  get '/search', to: 'books#serch'
  delete '/search', to: 'books#reset'
  get 'books/index', to: 'books#index'
  post 'books/new', to: 'books#create'
  
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    resources :books, only: [:index, :show]
    member do
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, only: [:create]
  end
  
  
  
  resources :reviews
  resources :books
  resources :posts
  resources :sessions
  resources :relationships, only: [:create, :destroy]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
