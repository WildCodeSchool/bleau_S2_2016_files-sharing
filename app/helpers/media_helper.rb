module MediaHelper

	def medium_display_by_type(medium)
		case medium.file.content_type
			when nil
				content_tag(:p,"Oops, we got an unexpected error")
			when /^image\/svg/
				image_tag medium.file, alt: medium.name
			when /^image/
				image_tag medium.file.thumb, alt: medium.name
			when /^video/
				video_tag medium.file.thumb, alt: medium.name
			when /^application\/pdf/
				image_tag medium.file.pdf_thumb, alt: medium.name
			else
				image_tag asset_path("default_media_display.svg"), alt: medium.name
		end
	end

	def medium_size_format_helper(medium)
		size = medium.size.to_i
		if size/1024 <= 1
			"#{size} octets"
		elsif size/1024**2 <= 1
			"#{(size.to_f/1024.0).round(1)} Kio"
		elsif size/1024**3 <= 1
			"#{(size.to_f/1024**2).round(1)} Mo"
		end
	end

	def search_my_files_ajax_uploaded_for_pagination_helper
		html_content = []
		Medium.search_in_my_files(current_user).page(params[:my_files_page]).each do |m|
			html_content << render('file_display', medium: m)
		end
		html_content.join.html_safe
	end

	def search_my_files_pagination_helper
		paginate Medium.search_in_my_files(current_user).page(params[:my_files_page]), param_name: :my_files_page, params: {controller: 'main', action: 'search_home_pagination'}, remote: true
	end

	def search_in_files_shared_with_me_or_with_my_groups_ajax_shared_for_pagination_helper
		html_content = []
		Medium.search_in_files_shared_with_me_or_with_my_groups(current_user).page(params[:shared_files_page]).each do |m|
			html_content << render('file_display', medium: m)
		end
		html_content.join.html_safe
	end

	def search_in_files_shared_with_me_or_with_my_groups_pagination_helper
		paginate Medium.search_in_files_shared_with_me_or_with_my_groups(current_user).page(params[:shared_files_page]), param_name: :shared_files_page, params: {controller: 'main', action: 'search_home_pagination'}, remote: true
	end

end