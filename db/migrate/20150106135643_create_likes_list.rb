class CreateLikesList < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :answer_id
    end
  end
end
