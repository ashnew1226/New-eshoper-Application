class AddProductIdToProductImages < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_images, :product, null: false, foreign_key: true
  end
end
