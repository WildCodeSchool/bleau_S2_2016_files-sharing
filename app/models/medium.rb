class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

  	belongs_to :user
  	has_many :shared_withs, dependent: :destroy, inverse_of: :medium
  	has_many :entities, through: :shared_withs

  	accepts_nested_attributes_for :shared_withs, reject_if: lambda{ |a| a[:selected] == '0'}
  	
end

