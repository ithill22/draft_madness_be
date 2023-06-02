Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resource :users, only: [:create]
      resource :user_leagues, only: %i[create destroy]
    end
  end
end
