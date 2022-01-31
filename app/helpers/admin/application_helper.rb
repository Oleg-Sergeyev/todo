# frozen_string_literal: true

module Admin::ApplicationHelper
  def activate_title(user)
    user.active? ? 'Active' : 'Disactive'
  end

  def generate_new_user
    email = FFaker::Internet.safe_email
    default_role = Role.new(name: 'Пользователь', code: :default)
    hash_user = {
                    name: email,
                    email: email,
                    password: email,
                    role: default_role,
                    active: [true, false].sample,
                    events_unffd_count: 0,
                    events_ffd_count: 0,
                    items_unffd_count: 0,
                    items_ffd_count: 0
                  }
    User.new(hash_user)
  end
end
