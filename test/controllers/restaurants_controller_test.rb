require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "guest can get index" do
    get restaurants_url
    assert_response :success
  end

  test "guest can search restaurants" do
    get restaurants_url, params: { q: "Paradise" }
    assert_response :success
  end

  test "guest can filter by cuisine" do
    get restaurants_url, params: { cuisine: "Biryani" }
    assert_response :success
  end

  test "guest can filter by pure veg" do
    get restaurants_url, params: { pure_veg: "true" }
    assert_response :success
  end

  test "guest can show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end
end
