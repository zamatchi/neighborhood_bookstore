Rails.application.routes.draw do
  devise_for :users
  root "homes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # config.action_mailer.default_url_options = { host: 'db', port: 3000 }
end
