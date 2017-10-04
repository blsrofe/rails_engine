Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show]
      namespace :merchants do
        get "random", to: 'random#show', as: 'random'
        get "find", to: 'search#show', as: 'find'
        get "find_all", to: 'search#index', as: 'find_all'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end


end
