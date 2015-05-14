Rails.application.routes.draw do
  resources :genres

  resource :session

  get "signin" => "sessions#new"

  resources :users

  get "signup" => "users#new"

  root "movies#index"

  # get "movies/filters/hits" => "movies#index", scope: 'hits'
  # get "movies/filters/flops" => "movies#index", scope: 'flops'
  get "movies/filter/:scope" => "movies#index", as: :filtered_movies
  resources :movies do
    resources :reviews
    resources :favorites
  end
end
