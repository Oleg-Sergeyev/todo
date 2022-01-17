# frozen_string_literal: true

class EventsFilter
  attr_accessor :user, :event, :data_scope

  def initialize(event, user)
    @user = user
    @event = event
    @data_scope = data
  end

  def data
    return scope.all if @user.admin?
    return scope.where(user: @user) if @user.default?
  end

  # scope :role, -> { where("@user.admin?") }

  # def resolve
  #   if user.admin?
  #     scope.all
  #   elsif user.premium?
  #     scope.where(published: true)
  #   else
  #     scope.where(published: true, premium: false)
  #   end
  # end

  # def resolve
  #   user.admin? ? scope.all : scope.where(user: user)
  # end
end
