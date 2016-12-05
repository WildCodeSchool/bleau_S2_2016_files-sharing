class AddNameToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :name, :string
  end
end
