class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many :comments, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :book_id, presence: true
  validates :content, presence: true
end
