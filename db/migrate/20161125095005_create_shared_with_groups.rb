class CreateSharedWithGroups < ActiveRecord::Migration[5.0]
  def change
  	create_table :shared_with_groups do |t|
      t.belongs_to :group, index: true
      t.belongs_to :medium, index: true
      t.timestamps
    end
  end
end