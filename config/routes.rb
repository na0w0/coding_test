Rails.application.routes.draw do
  root 'top#index'
  devise_for :users

  resources :users do
    resources :articles
  end

  # ログインユーザーの記事一覧
  # TODO: to: 'users#show'かindexにする
  get 'mypage', to: 'articles#index'
end
