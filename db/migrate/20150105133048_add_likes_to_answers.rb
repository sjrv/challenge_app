class AddLikesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :likes, :integer
  end
end
