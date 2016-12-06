class RemoveNomFromMedia < ActiveRecord::Migration[5.0]
  def change
    remove_column :media, :nom, :string
  end
end
