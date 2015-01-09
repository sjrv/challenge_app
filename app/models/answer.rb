class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :likes
  has_many :liked_by, through: :likes, source: :user
  after_destroy :remove_likes
  validates_length_of :contents, minimum: 1, allow_blank: false, message: "is required"

  def accept
    self.accepted = true
    self.user.add_points 25
    self.save
  end

  def unaccept
    self.accepted = false
    self.user.add_points -15
    self.save
  end

  def fix_likes
    self.likes_count = likes.count
    self.save
  end

  def like user
    self.user.add_points 5
    self.likes_count += 1
    self.likes.create user_id: user.id
    self.save
  end

  def unlike user
    self.user.add_points -5
    self.likes_count -= 1
    self.likes.find_by(user_id: user.id).destroy
    self.save
  end

  def points
    self.likes_count
  end

  def liked_by? user
    liked_by.include?(user)
  end

  def remove_likes
    likes.each{|like| like.destroy}
  end
end
