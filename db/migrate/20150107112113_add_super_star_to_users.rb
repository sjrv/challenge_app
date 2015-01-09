class AddSuperStarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superstar, :boolean
  end
end
