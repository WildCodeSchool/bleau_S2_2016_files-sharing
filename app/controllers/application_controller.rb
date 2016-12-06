class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # permet la prise en compte des champs perso de l'entité User par rapport
  # à la connection et l'inscription de devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
