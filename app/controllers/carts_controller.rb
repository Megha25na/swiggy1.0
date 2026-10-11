class CartsController < ApplicationController
  def show
    @items = cart.items
    @restaurant = cart.restaurant
  end

  def add_item
    product_id = params[:product_id]
    quantity = params[:quantity] || 1
    
    product = Product.find_by(id: product_id)
    if product
      cart.add_item(product.id, quantity)
      flash[:notice] = "Added #{product.name} to your cart."
    else
      flash[:alert] = "Item could not be found."
    end

    redirect_back fallback_location: cart_path
  end

  def update_quantity
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    cart.update_quantity(product_id, quantity)
    flash[:notice] = "Cart updated."

    redirect_back fallback_location: cart_path
  end

  def remove_item
    product_id = params[:product_id]
    cart.remove_item(product_id)
    flash[:notice] = "Item removed from cart."

    redirect_back fallback_location: cart_path
  end

  def clear
    cart.clear
    flash[:notice] = "Your cart is now empty."
    redirect_to cart_path
  end
end
