class MainController < ApplicationController

	before_action :authenticate_user!

	def index
	end

	def search_files
		if params[:select] == "All"
			@media = Medium.search_all(params[:search]).where(visible_to_all: true).page params[:page]
		elsif params[:select] == "My files"
			@media = Medium.search_in_my_files(current_user, params[:search]).page params[:page]
		elsif params[:select] == "Shared by my groups"
			@media = Medium.search_in_files_shared_by_my_groups(current_user, params[:search]).group_by_id.page params[:page]
		elsif params[:select] == "Shared with me"
			@media = Medium.search_in_files_shared_with_me(current_user, params[:search]).group_by_id.page params[:page]
		elsif params[:select] == "All files downloadable"
			@media = Medium.search_all_files_downloadable(current_user, params[:search]).page params[:page]
		end
	end

	def home
	end

	def search_home_pagination
	end

end
