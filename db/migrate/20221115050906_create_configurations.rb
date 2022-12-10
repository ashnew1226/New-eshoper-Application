class CreateConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :configurations do |t|

      t.timestamps
    end
  end
end
