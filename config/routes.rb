Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customers#show'
        get '/:id/merchant', to: 'merchants#show'
      end
      namespace :merchants do
        get "random", to: 'random#show', as: 'random'
        get "find", to: 'search#show', as: 'find'
        get "find_all", to: 'search#index', as: 'find_all'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
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
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchants#show'
      end
      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoices#show'
        get '/:id/item', to: 'items#show'
      end
      resources :transactions, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
