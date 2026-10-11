require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "sets default status on create" do
    order = Order.create!(
      user: users(:one),
      restaurant: restaurants(:one),
      total: 300
    )
    assert_equal "placed", order.order_status
    assert_equal "paid", order.payment_status
  end

  test "returns correct tracking step number" do
    order = orders(:one)
    order.order_status = "placed"
    assert_equal 1, order.tracking_step_number

    order.order_status = "preparing"
    assert_equal 3, order.tracking_step_number

    order.order_status = "delivered"
    assert_equal 5, order.tracking_step_number
  end
end
