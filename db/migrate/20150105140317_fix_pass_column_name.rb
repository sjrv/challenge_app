class FixPassColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :pass, :password
  end
end
