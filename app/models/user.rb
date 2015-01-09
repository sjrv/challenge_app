class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]

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

  def password_required?
    super && provider.blank?
  end

  def self.from_omniauth(auth)
    email = auth['info']['email']
    user = find_by_email(email)
    binding.pry
    return user if user
    user = create! email: email, name: auth['info']['nickname'], uid: auth['uid'], provider: auth['provider']
    binding.pry
    user
  end  
end
