class ChangeUserOrderDatatype < ActiveRecord::Migration[7.0]
  def change
    change_column :user_orders, :mobile_number, :string
  end
end
