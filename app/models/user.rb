class User < ApplicationRecord
 	# Include default devise modules. Others available are:
 	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    # relations avec les autres tables
	has_many :files, class_name: "Medium", dependent: :destroy
	has_many :shared_with_user
	has_many :user_in_group
	has_many :media, through: :shared_with_user, dependent: :destroy
	has_many :groups, through: :user_in_group
end
