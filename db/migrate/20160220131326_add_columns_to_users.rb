class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :age, :integer, default: 0
    add_column :users, :money, :integer, default: 0 
    add_column :users, :admin, :boolean, default: false 
  end
end
