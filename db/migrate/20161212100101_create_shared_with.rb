class CreateSharedWith < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_withs do |t|
      t.references :medium, foreign_key: true
      t.references :entity, foreign_key: true
      t.string :rights
      t.timestamps
    end
  end
end
