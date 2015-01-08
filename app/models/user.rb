class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable

  has_many :questions
  has_many :answers
  has_many :likes
  has_many :liked_answers, through: :likes, source: :answer

  mount_uploader :avatar, AvatarUploader
  
  after_create :set_points

  def set_points
    self.points = 100
    self.save
  end

  def to_s
    if self.name
      name
    else
      email
    end
  end

  def accepted_answers
    self.answers.where(accepted: true)
  end

  def add_points i
  	self.points += i
    self.superstar = true if self.points >= 1000
  	self.save
  end
end
