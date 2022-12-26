class RemoveParentIdFromCategorioes < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :parent_id, :integer
  end
end
# pi_3MJAi5SDCO9rQieo0vY5ULcA
# pi_3MJAi5SDCO9rQieo0vY5ULcA