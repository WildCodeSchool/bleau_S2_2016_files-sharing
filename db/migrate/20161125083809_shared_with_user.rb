class SharedWithUser < ActiveRecord::Migration[5.0]
  def change
  	create_table :shared_with_user do |t|
      t.belongs_to :user, index: true
      t.belongs_to :user, index: true
      t.timestamps
  end
end
