Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  namespace :api, path: '/' do
    resources :users, only: %i[create show update destroy]
  end
end
