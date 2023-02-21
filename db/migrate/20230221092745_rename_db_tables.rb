class RenameDbTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_orders, :orders
    rename_table :user_addresses, :addresses
  end
end
