class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cart_not_empty

  def new
    @restaurant = cart.restaurant
    @delivery_address = current_user.address.presence || "Flat 204, Royal Palms, FC Road, Pune, 411004"
    @contact_phone = current_user.phone.presence || "9876543210"
    @customer_name = current_user.name.presence || current_user.email.split("@").first.titleize
  end

  def create
    delivery_address = params[:delivery_address].to_s.strip
    contact_phone = params[:contact_phone].to_s.strip
    customer_name = params[:customer_name].to_s.strip
    payment_method = params[:payment_method].presence || "Cash on Delivery"
    notes = params[:notes].to_s.strip

    if delivery_address.blank? || contact_phone.blank?
      flash[:alert] = "Please provide both delivery address and contact phone."
      redirect_to checkout_path and return
    end

    ActiveRecord::Base.transaction do
      @order = Order.create!(
        user: current_user,
        restaurant: cart.restaurant,
        restaurant_id: cart.restaurant&.id,
        restru_id: cart.restaurant&.id,
        subtotal: cart.subtotal,
        delivery_fee: cart.delivery_fee,
        tax: cart.tax,
        discount: cart.discount,
        total: cart.total,
        order_status: "placed",
        payment_status: "paid",
        payment_method: "#{payment_method} (Demo)",
        payment_ref: "DEMO-TXN-#{SecureRandom.hex(4).upcase}",
        delivery_address: delivery_address,
        contact_phone: contact_phone,
        customer_name: customer_name,
        notes: notes
      )

      cart.items.each do |item|
        @order.items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.unit_price
        )
      end

      # Update user details if currently blank
      current_user.update(address: delivery_address) if current_user.address.blank?
      current_user.update(phone: contact_phone) if current_user.phone.blank?
      current_user.update(name: customer_name) if current_user.name.blank?

      cart.clear
    end

    redirect_to order_path(@order), notice: "🎉 Order placed successfully! Tracking your delivery now."
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Unable to place order: #{e.message}"
    redirect_to checkout_path
  end

  private

  def ensure_cart_not_empty
    if cart.empty?
      redirect_to restaurants_path, alert: "Your cart is empty. Please add items to checkout."
    end
  end
end
