# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.can?('users.read')
  end

  def show?
    index?
  end

  def create?
    user.can?('users.create')
  end

  def new?
    create?
  end

  def update?
    user.can?('users.update')
  end

  def edit?
    update?
  end

  def destroy?
    user.can?('users.delete')
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
