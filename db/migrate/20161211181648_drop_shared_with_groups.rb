class DropSharedWithGroups < ActiveRecord::Migration[5.0]
  def change
  	drop_table :shared_with_groups
  end
end
