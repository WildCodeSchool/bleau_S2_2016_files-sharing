class MainController < ApplicationController

	before_action :authenticate_user!
	before_action :is_user_authorized, only: [:download]

	def index
	end

	def search_files
		if params[:select] == "All"
			@media = Medium.search_all(params[:search])
		elsif params[:select] == "My files"
			@media = Medium.search_my_files(current_user, params[:search])
		elsif params[:select] == "Shared by groups"
			@media = Medium.search_files_shared_by_my_groups(current_user, params[:search])
		elsif params[:select] == "Me"
			@media = Medium.search_files_shared_with_me(current_user, params[:search])
		elsif params[:select] == "All files downloadable"
			@media = Medium.search_all_files_downloadable(current_user, params[:search])
		end
	end

	def home
	end

	def download
		path = "#{Rails.root}/public#{params[:path]}"
		if File.file? path
			send_file path
		else
			flash[:alert] = "there is a problem with this file, you can't donwload it"
			render "main/index"
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
			render "main/index"
		end
	end

end
