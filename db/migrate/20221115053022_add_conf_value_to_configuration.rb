class AddConfValueToConfiguration < ActiveRecord::Migration[7.0]
  def change
    add_column :configurations, :conf_value, :string
    add_column :configurations, :created_by, :integer
    add_column :configurations, :created_date, :date
    add_column :configurations, :modify_by, :integer
    add_column :configurations, :modify_date, :date
    # add_column :configurations, :status, :integer, default: 0

  end
end
