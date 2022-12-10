class AddConfKeyToConfiguration < ActiveRecord::Migration[7.0]
  def change
    add_column :configurations, :conf_key, :string


  end
end
