Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      get 'invoices/find', to: 'invoices/search#show'
    end
  end
end
