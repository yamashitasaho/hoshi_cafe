class Shop < ApplicationRecord
  validates :place_id, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :posts, dependent: :nullify
  # shopが消されたら、nullにする
end
