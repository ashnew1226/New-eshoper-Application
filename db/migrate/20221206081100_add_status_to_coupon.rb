class AddStatusToCoupon < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :status, :boolean
  end
end
