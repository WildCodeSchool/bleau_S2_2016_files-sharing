class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage]

	def homepage
	end

	def logged_homepage
		@media = current_user.media
		@owned_groups = Group.where("master_id = ?", current_user.entity.id)
	end

	def download
		send_file "#{Rails.root}/public#{params[:path]}"
	end

end
