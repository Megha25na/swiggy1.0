require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "guest can get products index" do
    get products_url
    assert_response :success
  end

  test "guest can filter products by search query" do
    get products_url, params: { q: "Biryani" }
    assert_response :success
  end

  test "guest can filter products by veg" do
    get products_url, params: { veg_only: "true" }
    assert_response :success
  end

  test "guest can show product" do
    get product_url(@product)
    assert_response :success
  end
end
