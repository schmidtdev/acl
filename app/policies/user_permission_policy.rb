class UserPermissionPolicy < ApplicationPolicy
  def index?
    user.can?("user_permissions.read") || user.can?("user_permissions.manage")
  end

  def create?
    user.can?("user_permissions.manage")
  end

  def destroy?
    user.can?("user_permissions.manage")
  end
end
