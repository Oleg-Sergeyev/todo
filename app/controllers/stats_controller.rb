# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @stat_users = User.order(:name)
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end
end
