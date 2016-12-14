class Entity < ApplicationRecord
	has_one :user
	has_one :group
	has_many :shared_withs
	has_many :media, through: :shared_withs
end
