Rails.application.routes.draw do
  resources :invites
  resources :work_preferences
  resources :nominations
  resources :users
  
  post '/search/users', to: 'search#search_index'
  get '/users/:id/account', to: 'users#current_user_account'
  post '/auth/google_oauth2/callback', to: 'google_auth#google_callback'

  get '/search/github/users', to: 'github_search#search_users'

end
