class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:idname]

  validates :idname, presence: true, uniqueness: true
  validates :name, presence: true

  # idnameを仕様してログインするようオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # 認証の条件式を変更する
      where(conditions).where(["idname = :value", {:value => idname}]).first
    else
      where(conditions).first
    end 
  end
  has_one :cart, dependent: :destroy
end
