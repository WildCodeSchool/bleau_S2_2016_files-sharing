class Entity < ApplicationRecord
	# optional: true est nécessaire car depuis rails 5 on ne peut pas créer 
	# le côté belongs_to si le côté has_one n'existe pas encore, optional
	# permet de passer outre cettre limitation
	belongs_to :type, polymorphic: true, optional: true
	has_many :shared_withs
	has_many :media, through: :shared_withs

	accepts_nested_attributes_for :shared_withs

	scope :all_groups, -> { where('type_type  = ?', 'Group') }
	scope :all_users, -> { where('type_type  = ?', 'User') }
	scope :order_by_date, -> { order("created_at DESC") }
end
