class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :book_id, presence: true
  validates :content, presence: true
  validates :evaluation, numericality: { 
    less_than_or_equal_to: 5, 
    greater_than_or_equal_to: 1
  },presence: true
end
