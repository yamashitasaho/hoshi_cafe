class Post < ApplicationRecord
  validates :region, presence: true, length: { maximum: 50 }
  validates :shop_name, presence: true, length: { maximum: 50 }
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, length: { maximum: 500 }

  belongs_to :user
end
