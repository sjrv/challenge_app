class RenameAnswerColumn < ActiveRecord::Migration
  def change
    rename_column :answers, :answered, :accepted
  end
end
