class AddUserIdToContact < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :user, null: false, foreign_key: true
  end
end
