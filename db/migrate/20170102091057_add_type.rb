class AddType < ActiveRecord::Migration[5.0]
  def change
    change_table :entities do |t|
      t.references :type, polymorphic: true, index: true
    end
  end
end
