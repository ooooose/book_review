class Book < ApplicationRecord
  belongs_to :user
  has_one :review
  has_many :posts, dependent: :destroy
end
