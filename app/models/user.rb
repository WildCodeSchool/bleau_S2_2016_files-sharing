class User < ApplicationRecord
	has_many :files, class_name: "Medium"
	has_many :shared_with_user
	has_many :user_in_group
	has_many :media, through: :shared_with_user
	has_many :groups, through: :user_in_group
end
