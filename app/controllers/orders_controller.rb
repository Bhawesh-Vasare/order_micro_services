class OrdersController < ApplicationController


  def index
    orders = Order.all
    render json: orders
  end

  def show
    order = Order.find(params[:id])
    product = ProductClient.get_product(order.product_id)
    if product 
        render json: {order: order, product: product}
    else 
        render json: {order: order, product: "Product not found" }
    end
  end  

  def create
    product = HTTParty.get("http://localhost:3001/products/#{order_params[:product_id]}")
    
    if product.success?
        order = Order.new(order_params)
        if order.save 
            render json: order, status: :created
        else
            render json: order.errors, status: :unprocessable_entity
        end
    else
        render json: {error: "Product not Found"}, status: :not_found
    end 
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :quantity, :total_price)
  end
end