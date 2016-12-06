# faire fonctionner les formulaire de devise en copier/coller sur n'importe quelle vue du site
module ApplicationHelper

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
