Rails.application.routes.draw do

  root 'pages#home'
  get '/home' => 'pages#home'

  # signup
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login and logout
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :users

end
