class CreateGroupRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :group_requests do |t|    
      t.references :medium, foreign_key: true
      t.references :entity, foreign_key: true
      t.timestamps
    end
  end
end
