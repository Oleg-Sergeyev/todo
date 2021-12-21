# frozen_string_literal: true

# class StatsUsers
class StatsUsers < ApplicationController
  class << self
    def get_data
      sql = 'SELECT
             users.name AS name,
             e.count_event AS events,
             SUM(i.count_item) AS items
             FROM users
             JOIN (SELECT id, (SELECT COUNT(*) FROM events WHERE user_id = users.id)
             AS count_event FROM users) e ON e.id = users.id
             JOIN (SELECT user_id, (SELECT COUNT(*) FROM items WHERE event_id = events.id)
             AS count_item FROM events) i ON i.user_id = users.id
             GROUP BY name, events
             ORDER BY users.name ASC;'
      ActiveRecord::Base.connection.exec_query(sql)
    end
  end
end
