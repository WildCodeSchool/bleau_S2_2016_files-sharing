class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

	belongs_to :user
	has_many :shared_withs, dependent: :destroy, inverse_of: :medium
	has_many :entities, through: :shared_withs

	accepts_nested_attributes_for :shared_withs, reject_if: lambda{ |a| a[:selected] == '0'}

	# svg de la taille et de l'extension du fichier
	before_save :update_file_size_and_extension

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

  	def update_file_size_and_extension
	    if file.present? && file_changed?
			self.extension = file.file.extension
			self.size = file.file.size
	    end
    end

end