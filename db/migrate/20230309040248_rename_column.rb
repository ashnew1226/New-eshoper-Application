class RenameColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :status
    add_column :users, :subscription, :boolean, default: false
  end
end
