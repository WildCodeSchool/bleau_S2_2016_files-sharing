class MainController < ApplicationController

	before_action :authenticate_user!

	def index
	end

	def search_files
		if params[:select] == "All"
			@media = Medium.search_all(params[:search])
		elsif params[:select] == "My files"
			@media = Medium.search_in_my_files(current_user, params[:search])
		elsif params[:select] == "Shared by groups"
			@media = Medium.search_in_files_shared_by_my_groups(current_user, params[:search])
		elsif params[:select] == "Me"
			@media = Medium.search_in_files_shared_with_me(current_user, params[:search])
		elsif params[:select] == "All files downloadable"
			@media = Medium.search_all_files_downloadable(current_user, params[:search])
		end
	end

	def home
	end

end
