class AddVisibleToAllTomedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :visible_to_all?, :boolean, :default => false
  end
end
