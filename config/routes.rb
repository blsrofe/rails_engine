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
        get ":id/revenue", to: 'revenue#show', as: 'total_revenue'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
    end
  end


end
