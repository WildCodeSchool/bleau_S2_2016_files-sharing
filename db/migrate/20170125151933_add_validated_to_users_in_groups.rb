class AddValidatedToUsersInGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :users_in_groups, :validated, :boolean
  end
end
