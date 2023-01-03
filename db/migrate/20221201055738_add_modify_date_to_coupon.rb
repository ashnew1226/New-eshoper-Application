class AddModifyDateToCoupon < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :modify_date, :date
    add_column :coupons, :modify_by, :int
    add_column :coupons, :code, :varchar
    add_column :coupons, :percent_off, :decimal, :precision => 15, :scale => 6
    add_column :coupons, :number_of_uses, :integer
    
  end
end
