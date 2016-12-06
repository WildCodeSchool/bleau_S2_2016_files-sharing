class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage ]

	def homepage
	end

	def login
		@my_files = current_user.my_files
	end

	def download
		send_file "#{Rails.root}/public#{params[:path]}"
	end

end
