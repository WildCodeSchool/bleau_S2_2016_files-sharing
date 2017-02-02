class UsersInGroup < ApplicationRecord
	belongs_to :user
	belongs_to :group

	scope :get_requests, -> (group) {
		where(UsersInGroup.arel_table[:user_id].eq(user.id))
		.and(UsersInGroup.arel_table[:group_id].eq(group.id))
	}

	# récupérer toutes les candidatures non validées dans les groupes possédés par l'utilisateur.
	scope :get_not_validated, -> (user) {
		where(
			UsersInGroup.arel_table[:validated].eq(0)
			.and(UsersInGroup.arel_table[:group_id].in(
				Group.my_groups(user).map{ |g| g.id }
			))
		)
	}
end
