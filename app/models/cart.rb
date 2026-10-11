class Cart
  attr_reader :session

  CartItem = Struct.new(:product, :quantity, :unit_price, :line_total)

  def initialize(session)
    @session = session
    @session[:cart] ||= {}
  end

  def raw_items
    @session[:cart] ||= {}
  end

  def add_item(product_id, quantity = 1)
    pid = product_id.to_s
    qty = quantity.to_i
    qty = 1 if qty < 1

    # Check if cart already has items from another restaurant
    prod = Product.find_by(id: pid)
    return false unless prod

    current_restaurant_id = restaurant&.id
    if current_restaurant_id.present? && current_restaurant_id != prod.restaurant_id
      # Different restaurant: reset cart or handle
      clear
    end

    raw_items[pid] = (raw_items[pid] || 0) + qty
    true
  end

  def update_quantity(product_id, quantity)
    pid = product_id.to_s
    qty = quantity.to_i
    if qty <= 0
      raw_items.delete(pid)
    else
      raw_items[pid] = qty
    end
  end

  def remove_item(product_id)
    raw_items.delete(product_id.to_s)
  end

  def clear
    @session[:cart] = {}
  end

  def items
    return [] if raw_items.blank?

    product_ids = raw_items.keys
    products = Product.includes(:restaurant).where(id: product_ids).index_by { |p| p.id.to_s }

    items_list = []
    raw_items.each do |pid, qty|
      product = products[pid]
      if product && qty > 0
        items_list << CartItem.new(
          product,
          qty,
          product.price,
          product.price * qty
        )
      else
        # Remove orphaned product from session
        raw_items.delete(pid)
      end
    end
    items_list
  end

  def total_items_count
    items.sum(&:quantity)
  end

  def subtotal
    items.sum(&:line_total)
  end

  def delivery_fee
    return 0 if items.empty?
    subtotal >= 500 ? 0 : 40
  end

  def tax
    return 0 if items.empty?
    (subtotal * 0.05).round # 5% GST
  end

  def discount
    0
  end

  def total
    return 0 if items.empty?
    subtotal + delivery_fee + tax - discount
  end

  def empty?
    items.empty?
  end

  def restaurant
    items.first&.product&.restaurant
  end
end
