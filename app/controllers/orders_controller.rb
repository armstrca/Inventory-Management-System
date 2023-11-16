#/workspaces/Inventory-Management-System/app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.includes(:products, :order_products).all
  end

  # GET /orders/incoming
  def incoming
    @incoming_orders = Order.incoming
  end

  # GET /orders/outgoing
  def outgoing
    @outgoing_orders = Order.outgoing
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  # GET /orders/new
  def new
    @order = Order.new
    authorize @order
  end

  def edit
    @order = Order.find(params[:id]) # Retrieve the order by its ID
    authorize @order

  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    authorize @order

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /orders/1 or /orders/1.json
def update
  @order = Order.find(params[:id])
  authorize @order

  # Process the order_params to remove empty strings from the products array
  processed_order_params = order_params
  if processed_order_params[:products].present?
    processed_order_params[:products]&.reject!(&:blank?)
  end

  respond_to do |format|
    if @order.update(processed_order_params)
      # Debugging line 1: Print the processed order_params to the console
      puts "Processed order_params: #{processed_order_params.inspect}"

      # Additional logic to associate products with the order
      if processed_order_params[:products].present?
        product_ids = processed_order_params[:products].reject(&:empty?).map(&:to_i)
        products = Product.where(id: product_ids)

        if products.count == product_ids.count
          # Debugging line 2: Print the list of product_ids and their count
          puts "Product IDs: #{product_ids.inspect}, Count: #{product_ids.count}"

          # All products exist, associate them with the order
          @order.products = products
          @order.save
          format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        else
          # Handle the case where some products don't exist
          format.html { render :edit, status: :unprocessable_entity, notice: "Some selected products do not exist." }
          format.json { render json: { error: "Some selected products do not exist." }, status: :unprocessable_entity }
        end
      else
        # No products selected, do nothing
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      end
    else
      # Debugging line 3: Print the errors if the order update fails
      puts "Order update failed. Errors: #{order.errors.full_messages}"

      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
  end
end



  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    authorize @order

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(
      :expected_delivery,
      :status,
      :description,
      :receiving_address,
      :sending_address,
      product_ids: [],
    )
  end

end
