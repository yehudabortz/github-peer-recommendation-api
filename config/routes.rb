Rails.application.routes.draw do
  resources :nominations
  # resources :users

  get '/users/:id/account', to: 'users#current_user_account'
  post '/auth/github_oauth2/callback', to: 'github_auth#github_callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
