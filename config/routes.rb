Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resources :users, only: %i[index show create] do
        resources :leagues, only: %i[index], controller: 'users/leagues'
      end
      resources :leagues, only: %i[create show update destroy] 
      resources :user_leagues, only: %i[create destroy]
      resources :teams, only: %i[index show]
      resources :roster_teams, only: %i[show create]
    end
  end
end
