class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.string :image_name

      t.timestamps
    end
  end
end
