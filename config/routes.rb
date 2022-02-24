Rails.application.routes.draw do
  
  get '/home', to: 'top#index'
  root 'top#index'
  
  get '/posts', to: 'posts#index'
  
  get '/search', to: 'books#serch'
  delete '/search', to: 'books#reset'
  get 'books/index', to: 'books#index'
  post 'books/new', to: 'books#create'
  
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/ranking', to: 'books#ranking'
  get '/evaluations', to: 'books#evaluations'
  
  resources :users do
    resources :books, only: [:index, :show]
    member do
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :books do
    resource :reviews  
  end
  resources :books
  resources :posts
  resources :sessions
  resources :relationships, only: [:create, :destroy]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
