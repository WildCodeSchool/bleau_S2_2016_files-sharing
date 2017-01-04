class Group < ApplicationRecord
	belongs_to :master, class_name: 'Entity'
	has_one :entity, as: :type, dependent: :destroy
	has_many :users_in_groups
	has_many :users, through: :users_in_groups

	accepts_nested_attributes_for :entity

	def self.my_groups(current_user)
		Group.where("master_id = ?", current_user.entity.id)
	end

	def self.related_groups(current_user)
		Group
			.joins("LEFT JOIN users_in_groups ON users_in_groups.group_id = groups.id")
			.where("master_id = ? OR users_in_groups.user_id = ?", current_user.entity.id, current_user.id)
	end

end
