class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

  	belongs_to :user
  	has_many :shared_withs, dependent: :destroy
  	has_many :entities, through: :shared_withs

end