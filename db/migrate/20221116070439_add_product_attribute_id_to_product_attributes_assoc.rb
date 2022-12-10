class AddProductAttributeIdToProductAttributesAssoc < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_attributes_assocs, :product_attributes, null: false, foreign_key: true
  end
end
