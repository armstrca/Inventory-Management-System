#/workspaces/Inventory-Management-System/app/controllers/subcategories_controller.rb
class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: %i[ show edit update destroy ]

  # GET /subcategories or /subcategories.json
  def index
    @subcategories = Subcategory.includes(:category, products: [:supplier]).all
    authorize @subcategory
  end

  # GET /subcategories/1 or /subcategories/1.json
  def show
    @subcategory = Subcategory.find(params[:id])
    authorize @subcategory
    # @products = @category.products.includes(:subcategory)
  end

  # GET /subcategories/new
  def new
    @subcategory = Subcategory.new
    authorize @subcategory
  end

  # GET /subcategories/1/edit
  def edit
    @subcategory = Subcategory.find(params[:id])
    authorize @subcategory
  end

  # POST /subcategories or /subcategories.json
  def create
    @subcategory = Subcategory.new(subcategory_params)
    authorize @subcategory
    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to subcategory_url(@subcategory), notice: "Subcategory was successfully created." }
        format.json { render :show, status: :created, location: @subcategory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subcategories/1 or /subcategories/1.json
  def update
    @subcategory = Subcategory.find(params[:id])
    authorize @subcategory
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        format.html { redirect_to subcategory_url(@subcategory), notice: "Subcategory was successfully updated." }
        format.json { render :show, status: :ok, location: @subcategory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategories/1 or /subcategories/1.json
  def destroy
    authorize @subcategory
    @subcategory.update(category_id: nil)
    @subcategory.update(category: nil)
    # Disassociate products from the subcategory
    @subcategory.products.each do |product|
      product.update(subcategory: nil)
    end

    @subcategory.destroy

    respond_to do |format|
      format.html { redirect_to subcategories_url, notice: "Subcategory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subcategory_params
    params.require(:subcategory).permit(:name, :description, :category_id)
  end
end
