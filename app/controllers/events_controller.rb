# frozen_string_literal: true
require 'classes/time_interval'
# class EventsController
class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  @rows_count = 5

  def index
    if cookies[:start_date].nil? && cookies[:final_date].nil? && cookies[:rows_count].nil?
      cookies.permanent[:start_date] = DateTime.now.beginning_of_day
      cookies.permanent[:final_date] = DateTime.now.end_of_day
      cookies.permanent[:rows_count] = @rows_count
    end
    @start_date = cookies[:start_date].to_time
    @final_date = cookies[:final_date].to_time
    @users = User.includes(:events)
    @events = TimeInterval.new([@start_date, @final_date], Event, :items)
                          .data_records.first.page(params[:page]).per(cookies[:rows_count])

  end

  # GET /events/1 or /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    if event_params.key?('start_date') || event_params.key?('final_date') || event_params.key?('rows_count')
      cookies.permanent[:rows_count] = event_params[:rows_count].to_i
      @rows_count = event_params[:rows_count].to_i
      # @start_date = event_params[:start_date].to_time
      # @final_date = event_params[:final_date].to_time
      # cookies.permanent[:start_date] = @start_date
      # cookies.permanent[:final_date] = @final_date
      @users = User.includes(:events)
      data = TimeInterval.new([event_params[:start_date], event_params[:final_date]], Event, :items).data_records
      @events = data.first.page(params[:page]).per(cookies[:rows_count])
      @start_date = data.second
      @final_date = data.third
      cookies.permanent[:start_date] = @start_date
      cookies.permanent[:final_date] = @final_date
      Rails.logger.info ">>>>>>>>>>>>>>>>>>>>#{data[1]}<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      render :index
    else
      @event = Event.new(event_params.merge(user: User.all.sample))
      respond_to do |format|
        if @event.save
          format.html { redirect_to event_url(@event), notice: 'Event was successfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :content, :done, :user, :start_date, :final_date, :rows_count)
  end
end
