Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do

      resource :users, only: [:create] 
      resource :leagues, only: [:create] 
      resource :user_leagues, only: %i[create destroy]
      get '/leagues', to: 'users/leagues#index'
      get '/leagues/:id', to: 'users/leagues#show', as: 'league'
      patch '/leagues/:id', to: 'users/leagues#update', as: 'update_league'
      delete '/leagues/:id', to: 'users/leagues#destroy', as: 'destroy_league'
    end
  end
end
