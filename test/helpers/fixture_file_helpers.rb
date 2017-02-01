module FixtureFileHelpers

	def encrypted_password(password = 'password123')
		User.new.send(:password_digest, password)
	end

	def resource
		@user = users(:one)
	end
  
end

ActiveRecord::FixtureSet.context_class.include FixtureFileHelpers