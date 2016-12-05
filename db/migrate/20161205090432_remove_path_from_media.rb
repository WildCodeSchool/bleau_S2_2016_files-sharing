class RemovePathFromMedia < ActiveRecord::Migration[5.0]
  def change
    remove_column :media, :path, :string
  end
end
