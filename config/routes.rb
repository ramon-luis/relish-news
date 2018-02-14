Rails.application.routes.draw do

  # root
  root 'pages#home'
  get '/home' => 'pages#home'

  # signup
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login and logout
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # user profile shortcut
  get '/profile' => 'users#show'
  get '/profile/edit' => 'users#edit'
  patch '/profile' => 'users#update'

  # users and favorites
  resources :users do
    resources :favorites
  end

  # confirmation page to delete user account
  get '/users/:id/delete' => 'users#delete'

  # topics
  # only want to show -> users do not get to add, update, or delete topics'
  get '/:route' => 'topics#show'


end
