class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|

      t.timestamps
    end
  end
end
