class CreateBannerManagements < ActiveRecord::Migration[7.0]
  def change
    create_table :banner_managements do |t|

      t.timestamps
    end
  end
end
