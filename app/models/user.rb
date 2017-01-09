class User < ApplicationRecord
 	# Include default devise modules. Others available are:
 	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    # relations avec les autres tables
    has_one :entity, as: :type, dependent: :destroy
    has_many :media
    has_many :users_in_groups
	has_many :groups, through: :users_in_groups

	accepts_nested_attributes_for :entity
	
	scope :search_all_except, -> (current_user, term) { 
		joins(:entity)
		.where(
			User.arel_table[:id]
				.not_eq(current_user.id)
			.and(Entity.arel_table[:name].matches("%#{term}%"))
		)
	}

	# rails passe en argument du constructeur les paramètres par le biais de la méthode create.
	# Ici on est obligé d'utiliser ||= pour la création de l'entité pour ne pas effacer les paramètres
	# déjà set sur l'entité en question dans le cas de params != nil
	def initialize(params = nil)
		super
		self.entity ||= self.build_entity
	end
end