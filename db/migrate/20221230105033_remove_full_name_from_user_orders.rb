class RemoveFullNameFromUserOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_orders, :full_name, :string
    remove_column :user_orders, :mobile_number, :string
    remove_column :user_orders, :address_1, :string
    remove_column :user_orders, :shipping_state, :string
    remove_column :user_orders, :shipping_city, :string
    remove_column :user_orders, :shipping_zipcode, :string
    remove_column :user_orders, :address_2, :string
    remove_column :user_orders, :billing_state, :string
    remove_column :user_orders, :billing_city, :string
    remove_column :user_orders, :billing_zipcode, :string
    # remove_column :user_orders, :email, :string
    rename_column :user_orders, :charge_id, :payment_id
  end
end
