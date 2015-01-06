class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :likes
  has_many :liked_by, through: :likes, source: :user

  def accept
  	self.accepted = true
  	self.user.add_points 25
  	self.save
  end

  def like user
  	self.user.add_points 5
  	self.likes.create user_id: user.id
  	self.save
  end

  def unlike user
  	self.user.add_points -5
  	self.likes.find_by(user_id: user.id).destroy
  	self.save
  end

  def points
  	likes.count
  end
end
