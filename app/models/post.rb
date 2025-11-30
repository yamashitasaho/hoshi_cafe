class Post < ApplicationRecord
  include ImageProcessable # 画像処理
  validates :region, presence: true, length: { maximum: 5 }
  validates :shop_name, presence: true, length: { maximum: 28 }
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, length: { maximum: 500 }

  belongs_to :user
  belongs_to :shop, optional: true   # shop_idは任意
  has_one_attached :image # 画像投稿
  has_one_attached :profile_image # プロフィール画像

  # ファイルの種類とサイズのバリデーション（gem ActiveStorage Validationを使用）
  ACCEPTED_CONTENT_TYPES = %w[
  image/jpeg
  image/png
  image/gif
  image/webp
  image/heic
  image/heif
].freeze

validates :image, content_type: ACCEPTED_CONTENT_TYPES,
                  size: { less_than_or_equal_to: 10.megabytes },
                  allow_blank: true
end
