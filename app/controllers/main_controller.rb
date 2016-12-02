class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage ]

	def homepage
	end

	def login
	end

end
