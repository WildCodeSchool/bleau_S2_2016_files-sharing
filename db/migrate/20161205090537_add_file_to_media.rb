class AddFileToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :file, :string
  end
end
