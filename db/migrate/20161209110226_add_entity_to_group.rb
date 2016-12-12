class AddEntityToGroup < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :entity, foreign_key: true
  end
end
