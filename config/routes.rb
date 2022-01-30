require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'
  resources :campaigns, except: [:new] do
    post 'rafle', on: :member # Exemplo: /campaigns/:id/rafle
    # post 'rafle', on: :collection # Exemplo: /campaigns/rafle
  end

  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :update, :destroy]
end