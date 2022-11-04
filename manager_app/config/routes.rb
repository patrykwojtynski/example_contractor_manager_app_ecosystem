Rails.application.routes.draw do
  resources :payment_requests, only: %i[index] do
    member do
      get :accept
      get :reject
    end
  end

  root "payment_requests#index"
end
