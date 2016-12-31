class User < ApplicationRecord
 	# Include default devise modules. Others available are:
 	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    # relations avec les autres tables
    belongs_to :entity, dependent: :destroy
    has_many :media
    has_many :users_in_groups
	has_many :groups, through: :users_in_groups

	accepts_nested_attributes_for :entity
	
	def self.search_all_except(current_user, term)
		User.joins(:entity).where('users.id != ? AND name REGEXP ?', current_user.id, "^#{term}") 
	end

	#devise passe un argument au constructeur, on est obligé d'en prévoir au moins 1
	def initialize(resource = nil)
		super
		self.entity ||= Entity.new
	end
end