require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "requires name and price" do
    product = Product.new(name: "", price: nil)
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
    assert_includes product.errors[:price], "can't be blank"
  end

  test "price must be non-negative" do
    product = Product.new(name: "Lassi", price: -10, restaurant: restaurants(:one))
    assert_not product.valid?
    assert_includes product.errors[:price], "must be greater than or equal to 0"
  end

  test "veg and non-veg scopes" do
    assert_includes Product.veg, products(:two)
    assert_includes Product.non_veg, products(:one)
  end
end
