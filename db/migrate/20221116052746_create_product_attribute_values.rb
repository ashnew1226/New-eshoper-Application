class CreateProductAttributeValues < ActiveRecord::Migration[7.0]
  def change
    create_table :product_attribute_values do |t|

      t.timestamps
    end
  end
end
