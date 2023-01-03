class AddProductIdToProductAttributesAssoc < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_attributes_assocs, :product, null: false, foreign_key: true
  end
end
