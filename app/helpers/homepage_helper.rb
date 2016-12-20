module HomepageHelper

	def owned_groups
		Group.where("master_id = ?", current_user.entity.id)
	end

	def in_groups
		current_user.groups
	end

	def my_media
		current_user.media
	end
end
