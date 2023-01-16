class CreateSalesReports < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_reports do |t|
      t.string :total_saled_products
      t.string :products_total_price
      t.string :customers_registered
      t.string :total_coupons
      t.string :coupons_used

      t.timestamps
    end
  end
end
