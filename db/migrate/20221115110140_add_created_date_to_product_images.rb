class AddCreatedDateToProductImages < ActiveRecord::Migration[7.0]
  def change
    add_column :product_images, :created_date, :date
    add_column :product_images, :created_by, :integer
    add_column :product_images, :status, :integer, default: 0
    add_column :product_images, :modify_by, :integer
    add_column :product_images, :modify_date, :date

  end
end
