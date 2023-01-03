class AddCategoryIdToProductCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_categories, :category, null: false, foreign_key: true
  end
end
