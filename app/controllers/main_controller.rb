class MainController < ApplicationController

	before_action :authenticate_user!

	def index
		@my_files = Medium.search_in_my_files(current_user).page(params[:page])
		@files_shared_with_me = Medium.search_in_files_shared_with_me_or_with_my_groups(current_user).page(params[:page])
	end

	def search_files
		if params[:select] == "All"
			@media = Medium.search_all(params[:search]).where(visible_to_all: true)
		elsif params[:select] == "My files"
			@media = Medium.search_in_my_files(current_user, params[:search])
		elsif params[:select] == "Shared by my groups"
			@media = Medium.search_in_files_shared_by_my_groups(current_user, params[:search]).group_by_id
		elsif params[:select] == "Shared with me"
			@media = Medium.search_in_files_shared_with_me(current_user, params[:search]).group_by_id
		elsif params[:select] == "All files downloadable"
			@media = Medium.search_all_files_downloadable(current_user, params[:search])
		end
	end

	def home
	end

	def search_home_page
	end

end
