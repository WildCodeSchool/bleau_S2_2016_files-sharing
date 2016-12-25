class MainController < ApplicationController

	before_action :authenticate_user!, except: [ :homepage]
	before_action :is_user_authorized, only: [:download]

	def homepage
	end

	def logged_homepage
	end

	def download
		path = "#{Rails.root}/public#{params[:path]}"
		if File.exist? path
			send_file path
		else
			flash[:alert] = "There is an error with this file"
			render "main/logged_homepage"
		end
	end

	private

	def is_user_authorized
		medium = Medium.find(params[:medium])
		# propriétaire du fichier
		has_file = true if medium.user == current_user
		# fichier accessible via groupe
		current_user.groups.each do |g|
			through_group  = true if medium.entities.include? g.entity
		end
		# fichier accessible via partage individuel
		through_individual = true if medium.entities.include? current_user.entity

		if !has_file && !through_group && !through_individual
			flash[:alert] = "You can't download this file"
			render "main/logged_homepage"
		end
	end

end
