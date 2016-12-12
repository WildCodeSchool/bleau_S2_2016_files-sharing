class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage]

	def homepage
	end

	def login
		@media = current_user.media
	end

	def download
		send_file "#{Rails.root}/public#{params[:path]}"
	end

end
