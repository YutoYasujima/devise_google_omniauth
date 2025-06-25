class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: [ :google_oauth2 ] # Google認証設定

  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  # Googleログイン(OmniAuth)を通じて認証されたユーザー情報から、
  # アプリ側のUserレコードを探す or 作成する処理
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # `name` カラムがある場合
      # user.avatar_url = auth.info.image # `avatar_url` カラムがある場合
    end
  end
end
