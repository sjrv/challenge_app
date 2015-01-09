class AddLikesCountToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :likes_count, :integer
  end
end
