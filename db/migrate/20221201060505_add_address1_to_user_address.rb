class AddAddress1ToUserAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :user_addresses, :billing_address, :string
    add_column :user_addresses, :shipping_address, :string
    add_column :user_addresses, :city, :string
    add_column :user_addresses, :state, :string
    add_column :user_addresses, :country, :string
    add_column :user_addresses, :zipcode, :varchar
  end
end
