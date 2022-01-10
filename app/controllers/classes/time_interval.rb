# frozen_string_literal: true

# class Journal
class TimeInterval
  attr_accessor :start_date, :final_date, :object, :data_records

  def initialize(dates, object, associated_object)
    @dates = dates
    @object = object
    @associated_object = associated_object
    @data_records = get_records
  end

  def get_records
    if @dates.first == '' && @dates.second == ''
      @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                           .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = @object.where(created_at: @object.select('MAX(created_at)'))
                           .pluck(:created_at).first.to_time.end_of_day
      @records = get_data(@start_date, @final_date)
    elsif @dates.first != '' && @dates.second != ''
      @start_date = @dates.first.to_time.beginning_of_day
      @final_date = @dates.second.to_time.end_of_day
      @records = get_data(@start_date, @final_date)
    elsif @dates.first == '' && @dates.second != ''
      @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                           .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = @dates.second.to_time.end_of_day
      @records = get_data(@start_date, @final_date)
    elsif @dates.second == '' && @dates.first != ''
      @start_date = @dates.first.to_time.beginning_of_day
      @final_date = DateTime.now.end_of_day
      @records = get_data(@start_date, @final_date)
    end
    [@records, @start_date, @final_date]
  end

  def get_data(start_date, final_date)
    @object.where(created_at: start_date...final_date).includes(@associated_object)
  end
end
