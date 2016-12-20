class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage]

	def homepage
	end

	def logged_homepage
	end

	def download
		send_file "#{Rails.root}/public#{params[:path]}"
	end

end
