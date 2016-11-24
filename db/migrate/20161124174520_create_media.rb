class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :nom
      t.text :path
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
