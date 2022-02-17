class User < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  
  has_secure_password
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
