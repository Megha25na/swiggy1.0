require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:two)
    @customer = users(:one)
    @order = orders(:one)
    @restaurant = restaurants(:one)
  end

  test "guest cannot access admin console" do
    get admin_root_url
    assert_redirected_to new_user_session_url
  end

  test "ordinary customer cannot access admin console" do
    sign_in @customer
    get admin_root_url
    assert_redirected_to root_url
  end

  test "admin can access admin console" do
    sign_in @admin
    get admin_root_url
    assert_response :success
  end

  test "admin can access restaurants list" do
    sign_in @admin
    get admin_restaurants_url
    assert_response :success
  end

  test "admin can create a restaurant" do
    sign_in @admin
    assert_difference("Restaurant.count", 1) do
      post admin_restaurants_url, params: {
        restaurant: {
          name: "Chai Point",
          cuisine: "Beverages, Snacks",
          rating: 4.3,
          delivery_time: "15-20 mins",
          price_for_two: 200,
          city: "Pune"
        }
      }
    end
    assert_redirected_to admin_restaurants_url
  end

  test "admin can access products list" do
    sign_in @admin
    get admin_products_url
    assert_response :success
  end

  test "admin can create a product" do
    sign_in @admin
    assert_difference("Product.count", 1) do
      post admin_products_url, params: {
        product: {
          restaurant_id: @restaurant.id,
          name: "Ginger Chai Flask",
          price: 150,
          category: "Beverages",
          is_veg: true,
          description: "Freshly brewed hot ginger tea"
        }
      }
    end
    assert_redirected_to admin_products_path
  end

  test "admin can update order status" do
    sign_in @admin
    patch admin_order_url(@order), params: { order_status: "preparing" }
    assert_redirected_to admin_orders_url
    @order.reload
    assert_equal "preparing", @order.order_status
  end
end
