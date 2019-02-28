Rails.application.routes.draw do
  root to: 'home#top'
  get '/about', to: "home#about"

  resources :sessions, only: [:new, :create, :show, :destroy]

  resources :users

  resources :posts do
    collection do
      post :confirm
    end
  end

  resources :favorites, only:[:create, :index, :destroy]
end
