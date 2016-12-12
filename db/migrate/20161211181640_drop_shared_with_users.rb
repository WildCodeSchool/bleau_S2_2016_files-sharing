class DropSharedWithUsers < ActiveRecord::Migration[5.0]
  def change
  	drop_table :shared_with_users
  end
end
