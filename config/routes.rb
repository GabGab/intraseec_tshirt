IntraseecTshirt::Application.routes.draw do
  match '/tab' => "sessions#create"
  root :to => 'users#show'

  resources :sessions, :only => ['new', 'create']
  resources :users, :only => ['new', 'create', 'show']
end
