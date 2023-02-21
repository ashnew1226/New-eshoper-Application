class ChangeForeignKeyForOrderDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :order_details, :user_order_id, :order_id
    rename_column :orders, :user_address_id, :address_id

  end
end
