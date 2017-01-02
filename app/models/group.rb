class Group < ApplicationRecord
	belongs_to :master, class_name: 'Entity'
	has_one :entity, as: :type, dependent: :destroy
	has_many :users_in_groups
	has_many :users, through: :users_in_groups

	accepts_nested_attributes_for :entity

	def self.my_groups(current_user)
		Group.where("master_id = ?", current_user.entity.id)
	end

end
