# frozen_string_literal: true

# class Journal
class TimeInterval
  attr_accessor :start_date, :final_date, :object, :records

  def initialize(dates, object, associated_object)
    @dates = dates
    @object = object
    @associated_object = associated_object
    @records = get_records
  end

  def get_records
    if @dates.first.nil? && @dates.second.nil?
      @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                           .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = @object.where(created_at: @object.select('MAX(created_at)'))
                           .pluck(:created_at).first.to_time.end_of_day
      records = get_data(@start_date, @final_date)
    elsif @dates.first && @dates.second
      @start_date = @dates.first.beginning_of_day
      @final_date = @dates.second.end_of_day
      records = get_data(@start_date, @final_date)
    elsif dates.first.nil?
      @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                           .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = @dates.second.last.end_of_day
      records = get_data(@start_date, @final_date)
    elsif dates.second.nil?
      @start_date = @dates.first.beginning_of_day
      @final_date = DateTime.now.end_of_day
      records = get_data(@start_date, @final_date)
    end
    [records, @start_date, @final_date]
  end

  def get_data(start_date, final_date)
    @object.where(created_at: start_date...final_date).includes(@associated_object)
  end
end
