class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

	belongs_to :user
	has_many :shared_withs, dependent: :destroy, inverse_of: :medium
	has_many :entities, through: :shared_withs
<<<<<<< 09d21545d46850524bd5fffcf26c1c7cbe27e866
=======

	accepts_nested_attributes_for :shared_withs, reject_if: lambda{ |a| a[:selected] == '0'}

	# chercher dans tous les fichiers du site
  scope :search_all, -> (search) { where("name REGEXP ?", "^#{search}") }
  scope :order_by_date, -> { order("created_at DESC") }

	# chercher dans tous les fichiers uploadé par le current user
	def self.search_my_files(current_user, search)
		Medium
			.where("user_id = ? AND name REGEXP ?", current_user.id, "^#{search}")
			.order("created_at DESC")
	end

	# chercher dans tous les fichiers partagés par un groupe dont le
	# current user fait parti
	def self.search_files_shared_by_my_groups(current_user, search)
		entities_id = []
		ApplicationController.helpers.in_groups_entities(current_user).each do |e|
			entities_id << e.id
		end
  	Medium
  		.joins(:shared_withs)
  		.where("entity_id IN (?) AND name REGEXP ?", entities_id, "^#{search}")
  		.order("created_at DESC")
	end

	# chercher dans les fichiers partagés spécifiquement avec le current user
	def self.search_files_shared_with_me(current_user, search)
  	Medium
  		.joins(:shared_withs)
  		.where("entity_id = ? AND name REGEXP ?", current_user.id, "^#{search}")
  		.order("created_at DESC")
	end

	# chercher dans les fichiers partagés avec le current user par groupe ou individuellement
	def self.search_all_files_downloadable(current_user, search)
		mine = search_my_files(current_user, search)
		shared = search_files_shared_with_me(current_user, search)
		shared_by_groups = search_files_shared_by_my_groups(current_user, search)
	  (mine+shared+shared_by_groups).uniq
	end
	
end
>>>>>>> correction js pour éviter plusieurs fois l'ajout d'un même user à la création d'un média

	accepts_nested_attributes_for :shared_withs, reject_if: lambda{ |a| a[:selected] == '0'}

	# chercher dans tous les fichiers du site
	scope :search_all, -> (search) { where(Medium.arel_table[:name].matches("%#{search}%")) }

	# chercher dans tous les fichiers uploadé par le current user
  	scope :search_in_my_files, -> (current_user, search) { 
		where(
			Medium.arel_table[:user_id]
				.eq(current_user.id)
				.and(Medium.arel_table[:name]
				.matches("%#{search}%"))
		)
  	}

	# chercher dans tous les fichiers partagés par les groupes dont le current user fait parti ou possède
	scope :search_in_files_shared_by_my_groups, -> (current_user, search) {
		joins(:shared_withs)
		.where(SharedWith.arel_table[:entity_id]
			.in(related_groups_entities_ids(current_user))
			.and(Medium.arel_table[:name].matches("%#{search}%"))
		)
	}

	# chercher tous les fichiers partagés spécifiquement avec l'utilisateur	
	scope :search_in_files_shared_with_me, -> (current_user, search) {
		joins(:shared_withs)
		.where(SharedWith.arel_table[:entity_id]
			.eq(current_user.entity.id)
			.and(Medium.arel_table[:name].matches("%#{search}%"))
		)
	}

	# chercher dans les fichiers partagés avec le current user par groupe ou individuellement
	def self.search_all_files_downloadable(current_user, search)
		mine = search_in_my_files(current_user, search)
		shared_with_me = search_in_files_shared_with_me(current_user, search)
		shared_by_groups = search_in_files_shared_by_my_groups(current_user, search)
	  (mine+shared_with_me+shared_by_groups).uniq
	end

	# recherche par date décroissante
	scope :order_by_date_desc, -> { order(created_at: :desc) }

	# permet de ne pas plusieurs fois le même élément
	scope :group_by_id, -> { group(:id) }

	private

	def self.related_groups_entities_ids(current_user)
		ids = []
		Group.my_related_groups(current_user).each do |g|
			ids << g.entity.id
		end
		return ids
	end

end