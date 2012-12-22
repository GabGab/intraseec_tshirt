IntraseecTshirt::Application.routes.draw do
  match '/tab' => "sessions#create"
  root :to => 'users#show'

  get 'sessions/create' => 'sessions#create', :as => 'create_session'

  resources :sessions, :only => ['new', 'create']
  resources :users, :only => ['edit', 'update', 'show']
end
