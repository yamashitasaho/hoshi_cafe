class Shop < ApplicationRecord
  validates :place_id, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :posts, dependent: :nullify
  # shopが消されたら、そのshopに紐づいているpostのshop_idをnullにする
end
