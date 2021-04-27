Rails.application.routes.draw do
  get 'session/create'
  get 'session/destroy'
  resources :nominations
  resources :users
  get '/auth/guthub'
  get '/auth/guthub/callback', to: 'session#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
