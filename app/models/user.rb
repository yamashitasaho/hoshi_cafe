class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,                                    # 必須入力
            uniqueness: true,                                  # 重複禁止
            format: { with: /\A[a-zA-Z0-9_.~-]+\z/,
            message: I18n.t("activerecord.attributes.user.username_format") }, # 文字種制限
            length: { minimum: 3, maximum: 20 }               # 文字数制限
end
