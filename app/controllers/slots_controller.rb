class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  # GET /slots
  # GET /slots.json
  def index
    @slots = Slot.all
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @slot = Slot.new
  end

  # GET /slots/1/edit
  def edit
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: I18n.t('slot_was_successfully_created') }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1
  # PATCH/PUT /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to @slot, notice: I18n.t('slot_was_successfully_updated') }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: I18n.t('slot_was_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  def destroy_all
    Slot.destroy_all
    redirect_to slots_url
  end

  def import
    if params[:csv_file].blank?
      redirect_to(slots_url, alert: :select_import_csv_file)
    else
      count = Slot.import(params[:csv_file])
      redirect_to(slots_url, notice: view_context.pluralize_sentence(count, "slot_import_success"))
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slot_params
      params.require(:slot).permit(:name, :from, :to)
    end
end
