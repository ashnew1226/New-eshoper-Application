class AddUserToUserOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_orders, :user, null: false, foreign_key: true
  end
end
