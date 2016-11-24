class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :rights

      t.timestamps
    end
  end
end
