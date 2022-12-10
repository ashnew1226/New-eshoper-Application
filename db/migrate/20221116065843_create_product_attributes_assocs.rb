class CreateProductAttributesAssocs < ActiveRecord::Migration[7.0]
  def change
    create_table :product_attributes_assocs do |t|

      t.timestamps
    end
  end
end
