class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage ]

	def homepage
	end

	def login
		@my_files = current_user.my_files
		@my_groups = current_user.groups
	end

end
