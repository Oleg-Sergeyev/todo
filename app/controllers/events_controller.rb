# frozen_string_literal: true

# class EventsController
class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  @rows_count = 5
  # GET /events or /events.json
  def index
    if cookies[:start_date].nil? && cookies[:final_date].nil? && cookies[:rows_count].nil?
      cookies.permanent[:start_date] = DateTime.now.beginning_of_day
      cookies.permanent[:final_date] = DateTime.now.end_of_day
      cookies.permanent[:rows_count] = @rows_count
    end
    @start_date = cookies[:start_date].to_time
    @final_date = cookies[:final_date].to_time
    @events = get_data(@start_date, @final_date)
    @users = User.includes(:events)
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
      @rows_count = event_params[:rows_count].to_i
      cookies.permanent[:rows_count] = event_params[:rows_count].to_i
      check_dates([event_params[:start_date].to_time, event_params[:final_date].to_time])
    else
      @event = Event.new(event_params.merge(user: User.first))
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

  def get_data(start_date = nil, final_date = nil)
    Event.where(created_at: start_date...final_date).includes(:items).page(params[:page]).per(cookies[:rows_count])
  end

  def render_query
    @users = User.includes(:events)
    render :index
  end

  def check_dates(dates)
    if dates.first.nil? && dates.last.nil?
      @events = Event.includes(:items).page(params[:page]).per(cookies[:rows_count])
      @start_date = Event.where(created_at: Event.select('MIN(created_at)'))
                         .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = Event.where(created_at: Event.select('MAX(created_at)'))
                         .pluck(:created_at).first.to_time.end_of_day
    elsif dates.first && dates.last
      @start_date = dates.first.beginning_of_day
      @final_date = dates.last.end_of_day
      @events = get_data(@start_date, @final_date)
    elsif dates.first.nil?
      @start_date = Event.where(created_at: Event.select('MIN(created_at)'))
                         .pluck(:created_at).first.to_time.beginning_of_day
      @final_date = dates.last.end_of_day
      @events = get_data(@start_date, @final_date)
    elsif dates.last.nil?
      @final_date = DateTime.now.end_of_day
      @start_date = dates.first.beginning_of_day
      @events = get_data(@start_date, @final_date)
    end
    cookies.permanent[:start_date] = @start_date
    cookies.permanent[:final_date] = @final_date
    render_query
  end
end
