Rails.application.routes.draw do
  get '/search', to: 'books#serch'
  delete '/search', to: 'books#reset'
  get 'books/index', to: 'books#index'
  post 'books/new', to: 'books#create'
  
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  
  resources :books
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
