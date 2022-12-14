class AddEmailToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :email, :string
    add_column :user_orders, :charge_id, :string
    add_column :user_orders, :error_message, :string
    add_column :user_orders, :customer_id, :string
    add_column :user_orders, :payment_gateway, :integer
    add_column :user_orders, :token, :string

  end
end
