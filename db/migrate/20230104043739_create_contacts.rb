class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :contact_no
      t.string :message
      t.text :note_admin

      t.timestamps
    end
  end
end
