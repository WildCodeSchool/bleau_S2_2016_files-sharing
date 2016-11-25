class User < ApplicationRecord
	has_many :media
	has_many :media, through: shared_with_user
end
