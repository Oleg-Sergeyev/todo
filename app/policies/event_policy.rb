
class EventPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      EventsFilter.new(scope, user).data_scope
    end
  end

  def show?
    record.user_id == user.id || user.admin?
  end

  def update?
    record.user_id == user.id || user.admin?
  end

  def destroy?
    record.user_id == user.id || user.admin?
  end
end
