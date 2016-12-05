class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage ]

	def homepage
	end

	def login
		@my_files = current_user.my_files
	end

end
