class AddQuantityToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :order_details, :quantity, :integer
    add_column :order_details, :amount, :decimal
  end
end
