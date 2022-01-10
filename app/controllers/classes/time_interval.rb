# frozen_string_literal: true

# class Journal
class TimeInterval
  attr_accessor :start_date, :final_date, :object, :data_records

  def initialize(dates, object, associated_object)
    @dates = dates.map(&:to_time)
    @object = object
    @associated_object = associated_object
    @data_records = [records, @start_date, @final_date]
  end

  def not_date
    return unless @dates.first.nil? && @dates.second.nil?

    @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                         .pluck(:created_at).first.to_time.beginning_of_day
    @final_date = @object.where(created_at: @object.select('MAX(created_at)'))
                         .pluck(:created_at).first.to_time.end_of_day
  end

  def date
    return unless datetime?(@dates.first) && datetime?(@dates.second)

    @start_date = @dates.first.beginning_of_day
    @final_date = @dates.second.end_of_day
  end

  def one_of_date
    if datetime?(@dates.first) && @dates.second.nil?
      @start_date = @dates.first.beginning_of_day
      @final_date = DateTime.now.end_of_day
    elsif @dates.first.nil? && datetime?(@dates.second)
      @start_date = @object.where(created_at: @object.select('MIN(created_at)'))
                           .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = @dates.second.end_of_day
    end
  end

  def records
    return get_data(@start_date, @final_date) if not_date
    return get_data(@start_date, @final_date) if date
    return get_data(@start_date, @final_date) if one_of_date
  end

  def get_data(start_date, final_date)
    @object.where(created_at: start_date...final_date).includes(@associated_object)
  end

  def datetime?(date)
    date.methods.include? :strftime
  end
end
