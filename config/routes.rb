Rails.application.routes.draw do
  namespace :api, path: '/' do
    resources :users, only: %i[create show update destroy]
  end
end
