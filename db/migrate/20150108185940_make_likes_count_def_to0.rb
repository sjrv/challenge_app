class MakeLikesCountDefTo0 < ActiveRecord::Migration
  def change
    change_column :answers, :likes_count, :integer, default: 0
  end
end
