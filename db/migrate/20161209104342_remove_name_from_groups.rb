class RemoveNameFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :name, :string
  end
end
