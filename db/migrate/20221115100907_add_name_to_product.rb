class AddNameToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :name, :string
    add_column :products, :sku, :string  
    add_column :products, :short_description, :string  
    add_column :products, :long_description, :text  
    add_column :products, :price, :decimal, precision: 14, scale: 2 
    add_column :products, :special_price, :decimal, precision: 14, scale: 2 
    add_column :products, :special_price_from, :date
    add_column :products, :special_price_to, :date
    add_column :products, :quantity, :integer, default: 1
    add_column :products, :meta_title, :string   
    add_column :products, :meta_description, :text   
    add_column :products, :meta_keywords, :text   
    add_column :products, :status, :integer, default: 0
    add_column :products, :created_by, :integer
    add_column :products, :created_date, :date
    add_column :products, :modify_by, :integer
    add_column :products, :modify_date, :date
  end
end
