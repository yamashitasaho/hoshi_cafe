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
  # googleでuidがあるなら重複はせず必須
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }# ->はuidがあるか確認した後で実行する

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image # プロフィール画像
  has_many :favorites, dependent: :destroy # お気に入り機能
  has_many :favorite_posts, through: :favorites, source: :post # 多対多の関係

  devise :database_authenticatable, # メール + パスワードでログイン
         :registerable, # ユーザー登録機能
         :recoverable, # パスワード忘れ機能
         :rememberable, # 「ログイン状態を保持」機能
         :validatable, # メール・パスワードの検証
         :omniauthable, # OAuth ログイン機能
         omniauth_providers: [ :google_oauth2 ] # Google OAuth を使う

  def self.from_omniauth(auth) # auth = Google から返ってきた認証情報オブジェクト
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.username = auth.info.email.split("@").first
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワード0から20文字
   end
  end

  def own?(object)
    id == object&.user_id
  end
  # ログインしてるユーザーID＝投稿したユーザーID

  def favorite(post)
    favorite_posts << post # お気に入り追加
  end

  def unfavorite(post)
    favorite_posts.destroy(post) # お気に入り削除
  end

  def favorite?(post)
    favorite_posts.include?(post) # お気に入り済み？
  end

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
