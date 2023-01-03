class AddFirstnameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :status, :integer, default: 0
    add_column :users, :created_date, :date
    add_column :users, :fb_token, :string
    add_column :users, :twitter_token, :string
    add_column :users, :google_token, :string
    add_column :users, :registration_method, :integer, default: 0

  end
end
