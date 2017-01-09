module MainHelper

	def owned_groups_entities
		owned = Group.my_groups(current_user)
		entities = []
		owned.each do |g|
			entities << g.entity
		end
		return entities
	end

	def in_groups_entities(user = nil)
		user ||= current_user
		entities = []
		user.groups.each do |g|
			entities << g.entity
		end
		return entities
	end



end
