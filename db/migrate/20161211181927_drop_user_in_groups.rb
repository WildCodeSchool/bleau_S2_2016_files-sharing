class DropUserInGroups < ActiveRecord::Migration[5.0]
  def change
  	drop_table :user_in_groups
  end
end
