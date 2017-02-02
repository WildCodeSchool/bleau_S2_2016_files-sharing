class DropGroupRequestsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :group_requests
  end
end
