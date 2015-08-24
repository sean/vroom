class PersonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?
      return scope.all if record.owner == user
    end
  end

  def show?
    user.try(:admin?) || record.owner == user
  end

  def update?
    user.try(:admin?) || record.owner == user
  end

  def create?
    user.try(:admin?) || record.owner == user
  end
end
