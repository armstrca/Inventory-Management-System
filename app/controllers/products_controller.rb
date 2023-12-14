# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :datatables

  # GET /products or /products.json
  def index
    @products = Product.all
    authorize(@products)
    respond_to do |format|
      format.html
      format.json { render(json: ProductDatatable.new(view_context).as_json) }
    end
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.includes(:category, :subcategory, :supplier).find(params[:id])
    authorize(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize(@product)
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    authorize(@product)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    authorize(@product)

    respond_to do |format|
      if @product.save
        format.html { redirect_to(product_url(@product), notice: "Product was successfully created.") }
        format.json { render(:show, status: :created, location: @product) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @product.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product = Product.find(params[:id])
    authorize(@product)
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to(product_url(@product), notice: "Product was successfully updated.") }
        format.json { render(:show, status: :ok, location: @product) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @product.errors, status: :unprocessable_entity) }
      end
    end
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the product with the given ID is not found
    flash[:alert] = "Product not found"
    redirect_to(products_url)
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    authorize(@product)
    respond_to do |format|
      format.html { redirect_to(products_url, notice: "Product was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def subcategories_by_category
    @product = Product.new
    authorize(@product)
    category_id = params[:category_id]
    subcategories = Subcategory.where(category_id: category_id)

    render(json: { subcategories: subcategories })
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :sku,
      :price,
      :stock_quantity,
      :category_id,
      :subcategory_id,
      :supplier_id,
      :company_id,
      :branch_id,
    )
  end
end
