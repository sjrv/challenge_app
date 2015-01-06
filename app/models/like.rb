class Like < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  validates_uniqueness_of :answer_id, scope: :user_id
end
