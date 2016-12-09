Rails.application.routes.draw do

  # Permet de diriger vers main/login.html.erb si l'utilisateur est connecté (utile si utilisateur souhaite svg son mdp)
  authenticated :user do
    root to: 'main#login'
  end

  # Si utilisateur non connecté, dirige vers main/homepage.html.erb
  root 'main#homepage'

  # permet l'ajout des routes nécessaires au bon fonctionnement de devise sur l'entité User.
  # on spécifie aussi qu'on souhaite surcharger le controller par défaut avec notre controller
  # dans /app/controllers/users/registrations_controller
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  # other routes
  get 'homepage' => 'main#homepage', as: :homepage
  get 'login' => 'main#login', as: :login
  post 'login/download' => 'main#download', as: :download
  
  # CRUD
  resources :groups
  resources :media

  # Redirige toute url inconnue vers root
  # CAUTION: This line will mask routing errors
  # get "*path", to: redirect('/')

end
