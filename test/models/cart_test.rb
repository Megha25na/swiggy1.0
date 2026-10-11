require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @session = {}
    @cart = Cart.new(@session)
    @product1 = products(:one) # price: 280
    @product2 = products(:two) # price: 240
  end

  test "starts empty" do
    assert @cart.empty?
    assert_equal 0, @cart.total_items_count
    assert_equal 0, @cart.total
  end

  test "can add item and calculate totals" do
    @cart.add_item(@product1.id, 2)
    assert_equal 2, @cart.total_items_count
    assert_equal 560, @cart.subtotal
    assert_equal 0, @cart.delivery_fee # free for >= 500
    assert_equal 28, @cart.tax # 5% of 560
    assert_equal 588, @cart.total
  end

  test "delivery fee is 40 for orders under 500" do
    @cart.add_item(@product2.id, 1) # 240
    assert_equal 240, @cart.subtotal
    assert_equal 40, @cart.delivery_fee
    assert_equal 12, @cart.tax
    assert_equal 292, @cart.total
  end

  test "can update quantity and clear" do
    @cart.add_item(@product1.id, 1)
    @cart.update_quantity(@product1.id, 4)
    assert_equal 4, @cart.total_items_count

    @cart.clear
    assert @cart.empty?
  end
end
