Rails.application.routes.draw do
  resources :users
  resource :session
  resources :goals do
    resources :cheers, except: :index
  end
  resources :comments
  resources :cheers, only: :index
  get "/leaderboard" => "cheers#index"
end
