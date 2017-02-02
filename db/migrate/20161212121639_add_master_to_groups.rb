class AddMasterToGroups < ActiveRecord::Migration[5.0]
  def change
	add_reference :groups, :master, foreign_key: {to_table: :entities}
  end
end
