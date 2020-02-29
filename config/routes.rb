Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/purchase_history', to: 'purchase_histories#index'
  post '/carts/add', to: 'carts#add'
  resources :carts, only: [:index, :edit, :update, :destroy]

  resources :products, only: [:show, :new, :create, :edit, :update, :destroy]
  
  resource :charge, only: [:create]
  
end