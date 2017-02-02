class AddSizeAndExtension < ActiveRecord::Migration[5.0]
  def change
  	add_column :media, :extension, :string
  	add_column :media, :size, :string
  end
end
