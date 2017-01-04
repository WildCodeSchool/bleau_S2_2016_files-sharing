class Group < ApplicationRecord
	belongs_to :master, class_name: 'Entity'
	has_one :entity, as: :type, dependent: :destroy
	has_many :users_in_groups
	has_many :users, through: :users_in_groups

	accepts_nested_attributes_for :entity

	# récupérer tous les groupes appartenants à l'utilisateur courant
	scope :my_groups, -> (current_user) { where(Group.arel_table[:master_id].eq(current_user.entity.id)) }
	# récupérer tous les groupes auxquels l'utilisateur courant est lié (possède ou appartient)
	scope :my_related_groups, -> (current_user) {
			joins(
				Group.arel_table
					.join(UsersInGroup.arel_table, Arel::Nodes::OuterJoin)
					.on(Group.arel_table[:id].eq(UsersInGroup.arel_table[:group_id])).join_sources
			)
			.where(
				(Group.arel_table[:master_id]
					.eq(current_user.entity.id))
					.or(UsersInGroup.arel_table[:user_id].eq(current_user.id))
			)
	}
	def self.related_groups(current_user)
		Group
			.joins("LEFT JOIN users_in_groups ON users_in_groups.group_id = groups.id")
			.where("master_id = ? OR users_in_groups.user_id = ?", current_user.entity.id, current_user.id)
	end

end
