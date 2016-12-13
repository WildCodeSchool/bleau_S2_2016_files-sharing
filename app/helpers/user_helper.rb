module UserHelper
	def owned_groups
		Group.where("master_id = ?", current_user.entity.id)
	end

	def owned_media
		current_user.media
	end

	def groups
		current_user.groups
	end
end
