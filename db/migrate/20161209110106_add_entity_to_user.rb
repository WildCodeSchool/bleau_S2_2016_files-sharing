class AddEntityToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :entity, foreign_key: true
  end
end
