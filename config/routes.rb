Rails.application.routes.draw do
  root 'top#index'
  devise_for :users

  # 一般ユーザー　特定のユーザーの記事一覧
  resources :users do
    resources :articles, only: :index
  end

  resources :articles
end
