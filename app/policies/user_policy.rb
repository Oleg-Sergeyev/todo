# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(id: user.id)
    end
  end

  def generate?
    user.admin?
  end

  def show?
    record.id == user.id || user.admin?
  end

  def update?
    record.id == user.id || user.admin?
  end

  def destroy?
    record.id == user.id || user.admin?
    # user.admin? && user.id != record.id
  end
end
