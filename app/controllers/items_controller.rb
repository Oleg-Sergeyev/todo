class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /event/items or /event/items.json
  def index
    #@event_items = Item.where(event_id: Event.include(:items).pluck(:id))
    @event = Event.find(params[:event_id])

    #@items = Item.where("event_id = #{params[:event_id]}")
    @item = Item.find(params[:id])
  end

  # GET /event/items/1 or /event/items/1.json
  def show
  end

  # GET /event/items/new
  def new
    @item = Item.new
  end

  # GET /event/items/1/edit
  def edit
    @event = Event.find(params[:event_id])
  end

  # POST /event/items or /event/items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @event_item.save
        format.html { redirect_to event_item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event/items/1 or /event/items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event/items/1 or /event/items/1.json
  def destroy
    @event_item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :done)
    end
end
