class Medium < ApplicationRecord
  belongs_to :user
  has_many :users, through: shared_with_user
end
