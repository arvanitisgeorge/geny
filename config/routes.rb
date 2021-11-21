Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products
      post '/signup', to: 'users#signup'
      post '/login', to: 'users#login'
      post '/signout', to: 'users#signout'
    end
  end
end