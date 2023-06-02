Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resource :users, only: [:create] 
      resource :leagues, only: [:create] 
      get '/leagues', to: 'users/leagues#index'
      get '/leagues/:id', to: 'users/leagues#show', as: 'league'
    end
  end
end
