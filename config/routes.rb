Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [] do
    resources :posts do
      resources :comments, only: [:create]
    end
  end

  # ログインユーザーの記事一覧
  resources :mypage, only: 'index'
end
