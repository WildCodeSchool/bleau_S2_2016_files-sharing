class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

  	belongs_to :user
  	has_many :shared_with
  	has_many :entities, through: :shared_with
end
