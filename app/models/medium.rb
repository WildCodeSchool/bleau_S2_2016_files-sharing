class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

  belongs_to :user
  has_many :shared_with_user
  has_many :shared_with_group
  has_many :users, through: :shared_with_user
  has_many :groups, through: :shared_with_group
end
