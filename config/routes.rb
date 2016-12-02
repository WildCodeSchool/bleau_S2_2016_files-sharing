Rails.application.routes.draw do

  # Permet de diriger vers main/login.html.erb si l'utilisateur est connecté (utile si utilisateur souhaite svg son mdp)
  authenticated :user do
    root to: 'main#login'
  end

  # Si utilisateur non connecté, dirige vers main/homepage.html.erb
  root 'main#homepage'

  # permet l'ajout des routes nécessaires au bon fonctionnement de devise sur l'entité User.
  devise_for :users

  # other routes
  get 'homepage' => 'main#homepage', as: :homepage
  
  # CRUD
  resources :groups
  resources :media
  resources :users

  # Redirige toute url inconnue vers root
  # CAUTION: This line will mask routing errors
  # get "*path", to: redirect('/')

end
