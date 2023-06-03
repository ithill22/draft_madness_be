Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do

      resources :users, only: [:create] do
        resources :leagues, only: [:index], controller: 'users/leagues'
      end
      resources :leagues, only: [:create, :show, :update, :destroy] 
      resources :user_leagues, only: [:create, :destroy]
      # get '/leagues', to: 'users/leagues#index'
    end
  end
end
