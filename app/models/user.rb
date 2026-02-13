class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyllist

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions

  before_update :prevent_unsetting_system
  before_destroy :prevent_destroy_system_user

  def can?(key)
    @permission_keys ||= permissions.pluck(:key).to_set
    @permission_keys.include?(key)
  end

  private

  def prevent_unsetting_system
    if system_was == true && system == false
      errors.add(:system, "cannot be unset for a system user")
      throw(:abort)
    end
  end

  def prevent_destroy_system_user
    if system?
      errors.add(:base, "cannot destroy a system user")
      throw(:abort)
    end
  end
end
