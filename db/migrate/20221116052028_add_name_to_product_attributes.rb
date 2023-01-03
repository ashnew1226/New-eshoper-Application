class AddNameToProductAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :product_attributes, :name, :string
    add_column :product_attributes, :created_by, :integer
    add_column :product_attributes, :created_date, :date
    add_column :product_attributes, :modified_by, :integer
    add_column :product_attributes, :modified_date, :date
  end
end
