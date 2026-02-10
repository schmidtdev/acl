class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyllist

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions

  def can?(key)
    permissions.exists?(key: key)
  end
end
