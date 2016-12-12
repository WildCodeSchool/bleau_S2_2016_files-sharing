class Group < ApplicationRecord
	belongs_to :entity
	has_many :users_in_groups
	has_many :users, through: :users_in_groups

	accepts_nested_attributes_for :entity
end
