class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :set_nickname_if_blank
  include ImageProcessable # 画像処理
  validates :username,
            presence: true,                                    # 必須入力
            uniqueness: true,                                  # 重複禁止
            format: { with: /\A[a-zA-Z0-9_.~-]+\z/,
            message: :username_format }, # 文字種制限
            length: { minimum: 3, maximum: 20 } # 文字数制限

  # validates :nickname, uniqueness: true ニックネームは重複しても良い
  validates :region, length: { maximum: 5 }
  validates :introduction, length: { maximum: 150 }

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image # プロフィール画像

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def own?(object)
    id == object&.user_id
  end
  # ログインしてるユーザーID＝投稿したユーザーID

  # ファイルの種類とサイズのバリデーション（gem ActiveStorage Validationを使用）
  ACCEPTED_CONTENT_TYPES = %w[
  image/jpeg
  image/png
  image/gif
  image/webp
  image/heic
  image/heif
].freeze

  validates :profile_image, content_type: ACCEPTED_CONTENT_TYPES,
                  size: { less_than_or_equal_to: 10.megabytes },
                  allow_blank: true

  private

  def set_nickname_if_blank
    self.nickname = username if nickname.blank?
  end
  # マイページ編集で名前を空にしてもusernameが設置されるようにする

end