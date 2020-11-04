Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  namespace :api, path: '/' do
    resources :users, only: %i[create show update destroy]
    resources :projects, only: %i[index create show update destroy]
    resources :tasks, only: %i[create show update destroy]
    resources :comments, only: %i[create show update destroy]
  end
end
