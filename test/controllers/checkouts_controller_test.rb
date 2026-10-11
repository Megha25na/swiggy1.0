require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @product = products(:one)
  end

  test "guest is redirected to sign in when accessing checkout" do
    get checkout_url
    assert_redirected_to new_user_session_url
  end

  test "customer with empty cart is redirected to restaurants" do
    sign_in @user
    get checkout_url
    assert_redirected_to restaurants_url
  end

  test "customer can checkout with items in cart" do
    sign_in @user
    post add_item_cart_url, params: { product_id: @product.id, quantity: 2 }

    get checkout_url
    assert_response :success

    assert_difference("Order.count", 1) do
      post checkout_url, params: {
        customer_name: "Test Customer",
        delivery_address: "123 FC Road, Pune",
        contact_phone: "9876543210",
        payment_method: "Cash on Delivery",
        notes: "Ring bell"
      }
    end

    new_order = Order.last
    assert_redirected_to order_url(new_order)
    assert_equal 2, new_order.items.first.quantity
  end
end
