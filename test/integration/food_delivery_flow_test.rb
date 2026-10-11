require "test_helper"

class FoodDeliveryFlowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:two)
    @restaurant = restaurants(:one)
    @product = products(:one)
  end

  test "complete customer food ordering lifecycle" do
    # 1. Visit homepage
    get root_url
    assert_response :success
    assert_select "h1", text: /Craving Delicious Food/

    # 2. Search for food
    get search_url, params: { q: "Biryani" }
    assert_response :success
    assert_select "h1", text: /Search results for "Biryani"/

    # 3. View Offers
    get offers_url
    assert_response :success
    assert_select "h1", text: /Restaurants with Great Offers/

    # 4. View Restaurants
    get restaurants_url
    assert_response :success

    # 5. View Restaurant details & menu
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "h1", text: @restaurant.name

    # 6. Add item to cart
    post add_item_cart_url, params: { product_id: @product.id, quantity: 2 }
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success
    assert_select "h3", text: @product.name

    # 7. Update quantity in cart
    patch update_quantity_cart_url, params: { product_id: @product.id, quantity: 3 }
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success

    # 8. Proceed to checkout (signing in)
    sign_in @user
    get checkout_url
    assert_response :success
    assert_select "h1", text: /Checkout & Delivery Details/

    # 9. Place order
    assert_difference("Order.count", 1) do
      post checkout_url, params: {
        customer_name: "Aman Sharma",
        delivery_address: "Flat 101, Shanti Niketan, Kothrud, Pune",
        contact_phone: "9823012345",
        payment_method: "Cash on Delivery",
        notes: "Ring bell twice"
      }
    end

    order = Order.last
    assert_redirected_to order_url(order)
    follow_redirect!
    assert_response :success
    assert_select "h1", text: /Order #ZGI-#{order.id}/
    assert_select ".step-label", text: "Order Placed"


    # 10. View Order history
    get orders_url
    assert_response :success
    assert_select "h1", text: "My Orders"

    # 11. View User profile
    get profile_url
    assert_response :success
    assert_select "h1", text: "My Profile"

    # 12. Admin advances order status
    sign_in @admin
    get admin_root_url
    assert_response :success

    patch admin_order_url(order), params: { order_status: "out_for_delivery" }
    assert_redirected_to admin_orders_url

    order.reload
    assert_equal "out_for_delivery", order.order_status

    # 13. Customer tracks advanced order
    sign_in @user
    get order_url(order)
    assert_response :success
    assert_select ".step-label", text: "On the Way"
  end
end
