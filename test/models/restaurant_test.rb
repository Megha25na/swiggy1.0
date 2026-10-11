require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  test "requires name" do
    restaurant = Restaurant.new(name: "")
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:name], "can't be blank"
  end

  test "valid with name" do
    restaurant = Restaurant.new(name: "Spice Garden", cuisine: "Indian")
    assert restaurant.valid?
  end

  test "has many products" do
    restaurant = restaurants(:one)
    assert_respond_to restaurant, :products
  end

  test "search scope finds matching restaurant" do
    results = Restaurant.search_by_keyword("Paradise")
    assert_includes results, restaurants(:one)
  end
end
