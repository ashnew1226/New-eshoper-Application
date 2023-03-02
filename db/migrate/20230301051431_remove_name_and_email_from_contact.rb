class RemoveNameAndEmailFromContact < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :name
    remove_column :contacts, :email
    rename_column :contacts, :note_admin, :replies

  end
end
