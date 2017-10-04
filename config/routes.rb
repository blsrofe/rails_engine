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
        get "most_items", to: 'most_items#index'
      end
      resources :invoices, only: [:index, :show]
      resources :merchants, only: [:index]
      resources :merchants, only: [:show] do
        get "revenue", to: 'revenue#show', as: 'total_revenue'
      end
    end
  end
end
