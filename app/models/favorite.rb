class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: {scope: :post_id}
  # 同じユーザーが同じ投稿を重複でお気に入りできないようにする
end
