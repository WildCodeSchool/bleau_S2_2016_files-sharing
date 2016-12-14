module UserHelper

	def owned_groups
		Group.where("master_id = ?", current_user.entity.id)
	end

end
