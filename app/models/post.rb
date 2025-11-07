class Post < ApplicationRecord
  validates :region, presence: true, length: { maximum: 50 }
  validates :shop_name, presence: true, length: { maximum: 50 }
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, length: { maximum: 500 }

  belongs_to :user
  belongs_to :shop, optional: true   # shop_idは任意
  has_one_attached :image # 画像投稿
end
