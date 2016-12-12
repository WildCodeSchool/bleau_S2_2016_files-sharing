module ApplicationHelper

# fonctions permettant l'inclusion du formulaire de sign_up de devise n'importe ou
  def resource_name
    :user
  end

  def resource_class 
     User 
  end

  # création d'une nouvelle entité si la resource appelée est vierge
  def resource
    @resource ||= User.new
    @resource.entity = Entity.new if @resource.entity.blank?
    return @resource
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
# end

end
