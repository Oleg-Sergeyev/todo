# frozen_string_literal: true

module Admin::ApplicationHelper
  def activate_title(user)
    user.active? ?  'Active' : 'Disactive'
  end

end
