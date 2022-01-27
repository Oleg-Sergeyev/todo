# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @stat_users = User.order(:name)
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    #get_data
  end

  # def get_data
  #   sql = 'SELECT
  #   users.name AS name,
  #   (SELECT COUNT(*) FROM events WHERE user_id = users.id) AS events,
  #   SUM(i.count_item) AS items
  #   FROM users
  #   JOIN (SELECT user_id, (SELECT COUNT(*) FROM items WHERE event_id = events.id)
  #   AS count_item FROM events) i ON i.user_id = users.id
  #   GROUP BY name, events
  #   ORDER BY users.name ASC;'
  #   Rails.logger.info "--------------------------------#{ActiveRecord::Base.connection.exec_query(sql).first}---------------------------------"
  # end
end
