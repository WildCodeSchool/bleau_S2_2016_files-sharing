class Medium < ApplicationRecord
	# carrierwave
	mount_uploader :file, FileUploader

	belongs_to :user
	has_many :shared_withs, dependent: :destroy, inverse_of: :medium
	has_many :entities, through: :shared_withs

	accepts_nested_attributes_for :shared_withs, reject_if: lambda{ |a| a[:selected] == '0'}

	# chercher dans tous les fichiers du site
	scope :search_all, -> (search) { where("name REGEXP ?", "^#{search}") }
	# chercher dans tous les fichiers uploadé par le current user
  	scope :search_in_my_files, -> (current_user, search) { 
		where(
			Medium.arel_table[:user_id]
				.eq(current_user.id)
				.and(Medium.arel_table[:name]
				.matches("%#{search}%"))
		)
  	}
	# chercher dans tous les fichiers partagés par les groupes dont le current user fait parti
	scope :search_in_files_shared_by_my_groups, -> (current_user, search) {
	  	joins(
	  		Medium.arel_table
	  			.join(Shared_withs.arel_table)
					.on(Medium.arel_table[:id])
					.eq(Shared_withs.arel_table[:medium_id]).join_sources
		)
	  	joins(Group.related_groups)
	  	.where(
			Medium.arel_table[:master_id]
				.eq(current_user.entity.id))
				.or(UsersInGroup.arel_table[:user_id].eq(current_user.id))"entity_id IN (?) AND name REGEXP ?", entities_id, "^#{search}")
	}
	# recherche par date décroissante
	scope :order_by_date_desc, -> { order("created_at DESC") }
  	# chercher tous les fichiers partagés avec l'utilisateur	

	# chercher dans les fichiers partagés spécifiquement avec le current user
	def self.search_in_files_shared_with_me(current_user, search)
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

