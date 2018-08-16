Rails.application.routes.draw do
  get 'commenters/top_ten'
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  resources :comments, only: [:create, :destroy]
  get "/commenters/top_ten", to: "commenters#top_ten"
end
