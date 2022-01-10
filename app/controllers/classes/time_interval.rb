# frozen_string_literal: true

# class Journal
class TimeInterval
  attr_accessor :start_date, :final_date, :object, :records

  def initialize(dates, object, associated_object)
    @dates = dates.map(&:to_time)
    @object = object
    @associated_object = associated_object
    @records = create_query
  end

  def create_query
    start_date = if @dates.first.nil?
                   @object.where(created_at: @object.select('MIN(created_at)'))
                          .pluck(:created_at).first.to_time.beginning_of_day
                 else
                   @dates.first.beginning_of_day
                 end
    final_date = if @dates.second.nil?
                   @object.where(created_at: @object.select('MAX(created_at)'))
                          .pluck(:created_at).first.to_time.end_of_day
                 else
                   @dates.second.end_of_day
                 end
    [@object.where(created_at: start_date...final_date).includes(@associated_object), start_date, final_date]
  end
end
