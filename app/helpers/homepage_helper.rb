module HomepageHelper

	def owned_groups_entities
		owned = Group.where("master_id = ?", current_user.entity.id)
		entities = []
		owned.each do |g|
			entities << g.entity
		end
		return entities
	end

	def in_groups_entities
		entities = []
		current_user.groups.each do |g|
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
