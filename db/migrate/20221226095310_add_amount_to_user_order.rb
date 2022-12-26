class AddAmountToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :amount, :string
  end
end
