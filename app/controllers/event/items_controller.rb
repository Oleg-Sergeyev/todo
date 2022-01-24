class Event::ItemsController < Event::ApplicationController
  before_action :set_event_item, only: %i[ show edit update destroy ]

  # GET /event/items or /event/items.json
  def index
    #@event_items = Item.all
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    @event_items = Item.where(event_id: Event.include(:items).pluck(:id))
    #Rails.logger.info "#--------------------------#{@event.id}---------------------------------------------"
    # Item.where(event_id: :id)
    # sql = '(SELECT code FROM roles WHERE id = users.role_id) as code, id, name, email, active, role_id, created_at'
    # @admin_users = admin_users.select(sql)
  end

  # GET /event/items/1 or /event/items/1.json
  def show
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # GET /event/items/new
  def new
    @event_item = Event::Item.new
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # GET /event/items/1/edit
  def edit
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # POST /event/items or /event/items.json
  def create
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    @event_item = Event::Item.new(event_item_params)

    respond_to do |format|
      if @event_item.save
        format.html { redirect_to event_item_url(@event_item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @event_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event/items/1 or /event/items/1.json
  def update
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    respond_to do |format|
      if @event_item.update(event_item_params)
        format.html { redirect_to event_item_url(@event_item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @event_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event/items/1 or /event/items/1.json
  def destroy
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
    @event_item.destroy

    respond_to do |format|
      format.html { redirect_to event_items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_item
      @event_item = Event::Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_item_params
      params.fetch(:event_item, {})
    end
end
