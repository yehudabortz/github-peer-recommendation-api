Rails.application.routes.draw do
  get 'session/create'
  get 'session/destroy'
  resources :nominations
  resources :users

  post '/auth/github_oauth2/callback', to: 'github_auth#github_callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
