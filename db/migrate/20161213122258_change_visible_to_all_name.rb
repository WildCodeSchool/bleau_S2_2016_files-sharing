class ChangeVisibleToAllName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :media, :visible_to_all?, :visible_to_all
  end
end
