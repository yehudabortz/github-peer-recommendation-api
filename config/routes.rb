Rails.application.routes.draw do
  resources :nominations

  get '/users/:id/account', to: 'users#current_user_account'
  post '/auth/github_oauth2/callback', to: 'github_auth#github_callback'

  get '/search/github/users', to: 'github_search#search_users'

end
