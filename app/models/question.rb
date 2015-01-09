class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  before_create :pay_points
  after_destroy :clear_answers

  validates_length_of :title, minimum: 1, allow_blank: false, message: "is required"

  validate :has_enough_points

  def has_enough_points
    if user.points < 10
      errors.add("You", "have not enough points")
    end
  end
  
  def author
    self.user
  end

  def pay_points
    self.user.add_points -10
  end

  def answered?
    answers.where(accepted: true).count > 0
  end
end
