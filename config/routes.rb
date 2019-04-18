Rails.application.routes.draw do
  root to: 'home#top'
  get '/about', to: "home#about"
  resources :sessions, only: [:new, :create, :show, :destroy]
  resources :users
  resources :posts do
    collection do
      post :confirm
    end
    resources :comments
  end
  resources :favorites, only:[:create, :index, :destroy]
  resources :contacts
  namespace :admin do
    resources :users
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :tags, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
