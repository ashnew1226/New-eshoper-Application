class AddUserAddressIdToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_orders, :user_address, null: false, foreign_key: true
  end
end
