Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # get 'carts/index'
  post '/carts/add', to: 'carts#add'
  resources :carts, only: [:index, :edit, :update, :destroy]

  resources :products, only: [:show, :new, :create, :edit, :update, :destroy]
  
  resource :charge, only: [:create]
  
end