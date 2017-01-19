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
				image_tag asset_path("defaut_media_display.svg"), alt: medium.name
		end
	end

	def medium_size_format(medium)
		size = medium.size.to_i
		if size/1024 <= 1
			"#{size} octets"
		elsif size/1024**2 <= 1
			"#{(size.to_f/1024.0).round(1)} Kio"
		elsif size/1024**3 <= 1
			"#{(size.to_f/1024**2).round(1)} Mo"
		end
	end

end