Rails.application.routes.draw do

  # root
  root 'news#home'
  get '/home' => 'news#home'

  # signup
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login and logout
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # user account shortcut
  get '/account' => 'users#show'
  get '/account/edit' => 'users#edit'
  patch '/account' => 'users#update'

  # user favorites shortcut
  get '/favorites' => 'favorites#index'

  # change rank in favorites
  get '/users/:user_id/favorites/:id/uprank' => 'favorites#uprank'
  get '/users/:user_id/favorites/:id/downrank' => 'favorites#downrank'

  # users and favorites
  resources :users do
    resources :favorites
  end

  # confirmation page to delete user account
  get '/users/:id/delete' => 'users#delete'

  # topics
  get '/topics/:route' => 'news#show'

  # search
  get '/search' => 'news#show'

end
