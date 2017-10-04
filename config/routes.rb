Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "random", to: 'random#show', as: 'random'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find", to: 'search#show', as: 'find'
        get "find_all", to: 'search#index', as: 'find_all'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end


end
