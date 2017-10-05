Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      namespace :merchants do
        get "random", to: 'random#show', as: 'random'
        get "find", to: 'search#show', as: 'find'
        get "find_all", to: 'search#index', as: 'find_all'
      end
      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index]
      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index]
      resources :merchants, only: [:show] do

      end
      resources :invoices, only: [:show] do
        get 'transactions', to: 'transactions#index'
        get 'invoice_items', to: 'invoice_items#index'
        get 'items', to: 'items#index'
        get 'customer', to: 'customers#show'
        get 'merchant', to: 'merchants#show'
      end
    end
  end


end
