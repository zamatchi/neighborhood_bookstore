Rails.application.routes.draw do
  get 'carts/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # devise_for :users, controllers: {
  #   registrations: 'registrations'
  # } 
  root "homes#index"

  resources :products, only: [:show, :new, :create, :edit, :update, :destroy]
  
end
