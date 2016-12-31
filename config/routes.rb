Rails.application.routes.draw do

  # Permet de diriger vers page d'accueil si user connecté
  authenticated :user do
    root to: 'main#index'
  end

  devise_scope :user do
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  # permet l'ajout des routes nécessaires au bon fonctionnement de devise sur l'entité User.
  # on spécifie aussi qu'on souhaite surcharger le controller par défaut avec notre controller
  # dans /app/controllers/users/registrations_controller
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  # other routes
  get 'index' => 'main#index', as: :index
  get 'login/download' => 'main#download', as: :download
  get 'search_files' => 'main#search_files', as: :search_files_modal
  get 'home' => 'main#home', as: :home_modal
  get 'search_users' => 'media#search_users'
  
  # CRUD
  resources :groups
  resources :media

end
