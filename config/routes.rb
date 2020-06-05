Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post '/authenticate_user', to: 'authentication#authenticate_user'
    resources :transactions, only: :create
  end

  devise_for :users
  root to: 'users#index'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
