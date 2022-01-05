# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    @start_date = DateTime.now.beginning_of_day
    @final_date = DateTime.now.end_of_day
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
    if event_params.key?('start_date') || event_params.key?('final_date')
      @events = get_data(DateTime.parse(event_params[:start_date]).beginning_of_day, DateTime.parse(event_params[:final_date]).end_of_day)
      @users = User.includes(:events)
      @start_date = DateTime.parse(event_params[:start_date]).beginning_of_day
      @final_date = DateTime.parse(event_params[:final_date]).end_of_day
      render :index
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
    params.require(:event).permit(:name, :content, :done, :user, :start_date, :final_date)
  end

  def get_data(start_date = nil, final_date = nil)
    Event.where(created_at: start_date..final_date).includes(:items).page(params[:page]).per(10)
  end
end
