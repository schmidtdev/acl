class MePolicy < ApplicationPolicy
  def show?
    user.can?('me.read')
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
