Rails.application.routes.draw do
  
  # ホーム画面をrootに設定
  root 'top#index'

  # アクションを限定できるような気もする？
  resources :posts
  resources :books
  resources :users

  # 本を探すためのルーティング 
  get '/search', to: 'books#serch'
  delete '/search', to: 'books#reset'
 
  # セッション機能のルーティング 
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 「いいね」ランキング機能のページ遷移
  get '/ranking', to: 'books#ranking'

  # 所持する本を５段階評価する
  get '/evaluations', to: 'books#evaluations'
  
  # ユーザーのルーティングに所持する本の情報とフォロー機能をネスト 
  resources :users do
    resources :books, only: [:index, :show]
    member do
      get :following, :followers
    end
  end
 
  # 投稿とそれに対するコメントのルーティング 
  resources :posts do
    resources :comments, only: [:create]
  end

  # 本に対するレビューのルーティング
  resources :books do
    resource :reviews  
  end

  # フォローに関するルーティング
  resources :relationships, only: [:create, :destroy]

  # いいね機能のルーティング
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
end
