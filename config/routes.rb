Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'top#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [] do
    resources :posts, only: [:index, :show]
  end

  resources :posts, except: [:index, :show] do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # ログインユーザーの記事一覧
  resources :mypage, only: 'index'
end
