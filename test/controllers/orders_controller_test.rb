require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @user = users(:one)
  end

  test "guest is redirected to sign in when accessing orders" do
    get orders_url
    assert_redirected_to new_user_session_url
  end

  test "customer can get order history" do
    sign_in @user
    get orders_url
    assert_response :success
  end

  test "customer can show order" do
    sign_in @user
    get order_url(@order)
    assert_response :success
  end

  test "customer can reorder past order" do
    sign_in @user
    post reorder_order_url(@order)
    assert_redirected_to cart_url
  end
end
