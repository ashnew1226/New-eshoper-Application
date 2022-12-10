class AddUserOrderIdToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_details, :user_order, null: false, foreign_key: true
  end
end
