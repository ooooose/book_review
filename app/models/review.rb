class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :book_id, presence: true
  validates :content, presence: true
end
