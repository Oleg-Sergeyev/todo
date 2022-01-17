# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @stat_users = User.order(:name)
  end
end
