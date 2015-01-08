class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  before_create :pay_points
  after_destroy :clear_answers

  validates_length_of :title, minimum: 1, allow_blank: false, message: "is required"

  def author
    self.user
  end

  def clear_answers
  	answers.each{|answer| answer.destroy}
  end

  def pay_points
  	self.user.add_points -10
  end

  def answered?
  	answers.where(accepted: true).count > 0
  end
end
