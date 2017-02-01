class ApplicationController < ActionController::Base

	include Pundit
	
  	protect_from_forgery with: :exception
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

	def user_not_authorized
		flash[:warning] = "You are not allowed to perform this action."
		redirect_to request.referrer
	end

	# Overwriting the sign_out redirect path method
	def after_sign_out_path_for(resource_or_scope)
		new_user_registration_path
	end

end
