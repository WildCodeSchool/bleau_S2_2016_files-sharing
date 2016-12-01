class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage, :subscribe ]

	def homepage
	end

	def login
	end

	def subscribe
	end

end
