class RemoveParentIdFromCategorioes < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :parent_id, :integer
  end
end
