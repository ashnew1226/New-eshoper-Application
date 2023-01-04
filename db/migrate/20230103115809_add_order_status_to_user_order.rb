class AddOrderStatusToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :order_status, :integer
  end
end
