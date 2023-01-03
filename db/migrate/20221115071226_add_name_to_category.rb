class AddNameToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :name, :string
    add_column :categories, :parent_id, :integer
    add_column :categories, :created_by, :string
    add_column :categories, :created_date, :date
    add_column :categories, :modify_by, :integer
    add_column :categories, :modify_date, :date
    add_column :categories, :status, :integer, default: 0

    # status enum
  end
end
