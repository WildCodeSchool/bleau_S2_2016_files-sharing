class Group < ApplicationRecord
	has_many :user_in_group
	has_many :shared_with_group
	has_many :users, through: :user_in_group
	has_many :media, through: :shared_with_group
end
