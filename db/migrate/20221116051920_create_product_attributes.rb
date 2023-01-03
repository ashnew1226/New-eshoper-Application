class CreateProductAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :product_attributes do |t|

      t.timestamps
    end
  end
end
