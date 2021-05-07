Rails.application.routes.draw do
  resources :nominations
  resources :users

  get '/users/:id/account', to: 'users#current_user_account'
  post '/auth/github_oauth2/callback', to: 'github_auth#github_callback'
  post '/auth/google_oauth2/callback', to: 'google_auth#google_callback'

  get '/search/github/users', to: 'github_search#search_users'

end
