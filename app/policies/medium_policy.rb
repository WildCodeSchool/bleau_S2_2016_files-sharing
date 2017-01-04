class MediumPolicy

	# pungit se débrouille ppur que le user récupéré soit le current_user, le 2eme objet peut etre nawak
	attr_reader :user, :medium

	def initialize(user, medium)
		@medium = medium
		@user = user
	end

	def download?
		is_user_authorized?
	end

	private

	def is_user_authorized?
		# propriétaire du fichier
		has_file = true if @medium.user == @user
		# fichier accessible via groupe
		through_group = false

		Group.related_groups(@user) do |g|
			through_group ||= @medium.entities.include? g.entity
		end
		# fichier accessible via partage individuel
		through_individual = @medium.entities.include? @user.entity

		has_file || through_group || through_individual
	end

end