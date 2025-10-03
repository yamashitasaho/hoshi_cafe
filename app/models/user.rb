class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :username,
            presence: true,                                    # 必須入力
            uniqueness: true,                                  # 重複禁止
            format: { with: /\A[a-zA-Z0-9_.~-]+\z/,
            message: :username_format }, # 文字種制限
            length: { minimum: 3, maximum: 20 } # 文字数制限
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def own?(object)
    id == object&.user_id
  end
  # ログインしてるユーザーID＝投稿したユーザーID
end
