Rails.application.routes.draw do
  get 'users/index'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :customers, only: [:index, :create, :show, :update, :destroy]
      resources :users, only: [:index]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
