Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  namespace :api, path: '/' do
    resources :projects, only: %i[index create show update destroy]
    with_options only: %i[create show update destroy] do |list_only|
      list_only.resources :users
      list_only.resources :tasks
      list_only.resources :comments
    end
    delete 'attachment', to: 'attachments#destroy' , as: 'delete_attachment'
    post 'attachment', to: 'attachments#create' , as: 'create_attachment'
  end
end
