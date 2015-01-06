class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :likes
  has_many :liked_by, through: :likes, source: :user
  after_destroy :remove_likes

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

  def liked_by? user
  	liked_by.include?(user)
  end

  def remove_likes
  	likes.each{|like| like.destroy}
  end
end
