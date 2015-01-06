class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  after_create :pay_points

  def pay_points
  	self.user.add_points -10
  end
end
