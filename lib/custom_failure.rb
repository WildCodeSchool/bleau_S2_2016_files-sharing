# permet de modifier la redirection après une tentative de login raté
# ici on renvoie vers homepage au lieu de la vue sign_in de devise
class CustomFailure < Devise::FailureApp
  def redirect_url
    :homepage
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end