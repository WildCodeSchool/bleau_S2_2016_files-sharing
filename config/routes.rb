Rails.application.routes.draw do
  resources :groups
  resources :media
  resources :users
  root 'main#homepage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
