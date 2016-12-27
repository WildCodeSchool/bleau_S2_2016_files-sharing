module HomepageHelper

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

	def all_groups_entities
		all = owned_groups_entities
		in_groups_entities.each do |entity|
			all << entity
		end
		return all
	end

end
