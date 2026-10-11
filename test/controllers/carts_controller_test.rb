require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get cart page" do
    get cart_url
    assert_response :success
  end

  test "should add item to cart" do
    post add_item_cart_url, params: { product_id: @product.id, quantity: 2 }
    assert_redirected_to cart_url
  end

  test "should update quantity in cart" do
    post add_item_cart_url, params: { product_id: @product.id, quantity: 1 }
    patch update_quantity_cart_url, params: { product_id: @product.id, quantity: 3 }
    assert_redirected_to cart_url
  end

  test "should remove item from cart" do
    post add_item_cart_url, params: { product_id: @product.id, quantity: 1 }
    delete remove_item_cart_url, params: { product_id: @product.id }
    assert_redirected_to cart_url
  end

  test "should clear cart" do
    post add_item_cart_url, params: { product_id: @product.id, quantity: 1 }
    delete clear_cart_url
    assert_redirected_to cart_url
  end
end
