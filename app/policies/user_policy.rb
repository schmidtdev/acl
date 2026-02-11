class UserPolicy < ApplicationPolicy
  def index?
    user.can?('users.read')
  end

  def show?
    index? || record.id == user.id
  end

  def create?
    user.can?('users.create')
  end

  def update?
    user.can?('users.update') || record.id == user.id
  end

  def destroy?
    user.can?('users.delete')
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.can?('users.read')

      scope.none
    end
  end
end
