IntraseecTshirt::Application.routes.draw do
  root :to => 'users#show'

  resources :sessions, :only => ['new', 'create']
end
