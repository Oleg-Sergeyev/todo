class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    #@events = Event.includes(:items).page(params[:page]).per(5)
    #@events = Event.includes(:items).page(params[:page]).per(10)
    @events = Event.where('created_at > ?', DateTime.now).includes(:items).page(params[:page]).per(10)
    @users = User.includes(:events)
    @date = DateTime.now
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    if event_params.key?('date') #&& event_params[:date] != ''
      Rails.logger.info "GET DATE = #{event_params[:date]}"
      @events = Event.where('created_at > ?', DateTime.parse(event_params[:date])).includes(:items).page(params[:page]).per(10)
      @users = User.includes(:events)
      @date = DateTime.parse(event_params[:date])
      render :index, status: :unprocessable_entity
    else
      @event = Event.new(event_params.merge(user: User.first))

      respond_to do |format|
        if @event.save
          format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
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
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
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
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
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
      params.require(:event).permit(:name, :content, :done, :user, :date)
    end
end
