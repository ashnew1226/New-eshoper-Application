class AddEmailToUserOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :user_orders, :email, :string
  end
end
