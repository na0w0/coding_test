Rails.application.routes.draw do
  root 'top#index'
  devise_for :users

  # 一般ユーザー
  # 特定のユーザーの記事一覧と詳細
  resources :users do
    resources :articles, only: %w(index show)
  end

  # ログインユーザーの記事一覧
  # TODO: to: 'users#show'かindexにする
  get 'mypage', to: 'articles#index'
  resources :articles
end
