class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage]

	def homepage
	end

	def logged_homepage
		@owned_groups = helpers.owned_groups
		@owned_media = current_user.media
		@groups = current_user.groups
	end

	def download
		send_file "#{Rails.root}/public#{params[:path]}"
	end

end
