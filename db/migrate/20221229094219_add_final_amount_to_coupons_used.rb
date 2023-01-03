class AddFinalAmountToCouponsUsed < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons_useds, :final_amount, :integer
  end
end
