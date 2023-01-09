class CreateContentManagementSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :content_management_systems do |t|
      t.string :title
      t.string :content
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps
    end
  end
end
