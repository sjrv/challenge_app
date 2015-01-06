class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable

  has_many :questions
  has_many :answers
  has_many :likes
  has_many :liked_answers, through: :likes, source: :answer

  def to_s
    name
  end

  def add_points i
  	self.points += i
  	self.save
  end

  def superstar?
  	self.points >= 1000
  end
end
