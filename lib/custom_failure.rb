# permet de modifier la redirection après une tentative de login raté
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