class AddAttributeValueToProductAttributeValues < ActiveRecord::Migration[7.0]
  def change
    add_column :product_attribute_values, :attribute_value, :string
    add_column :product_attribute_values, :created_by, :integer
    add_column :product_attribute_values, :created_date, :date
    add_column :product_attribute_values, :modified_by, :integer
    add_column :product_attribute_values, :modified_date, :date
  end
end
