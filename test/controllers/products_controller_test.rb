require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @product = products(:one)
  end

  routes = [
    {action: 'create', method: :post, url: '/products', params: { product: { description: 'description', name: 'name' } }},
    {action: 'edit', method: :get, url: '/products/1/edit', params: nil},
    {action: 'update', method: :patch, url: '/products/1', params: { product: { description: 'description', name: 'name' } }},
    {action: 'destroy', method: :delete, url: '/products/1', params: nil},
  ]

  routes.each do |route|
    test "should not have #{route[:action]} route" do
      assert_raises(ActionController::RoutingError) do
        send(route[:method], route[:url], params: route[:params])
      end
    end
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should redirect to sign in if user tries to add product to cart" do
    get add_to_cart_product_url(@product)
    assert_redirected_to new_user_session_url
  end

  test "should add product to cart if user is logged in" do
    user = users(:one)
    sign_in user

    get add_to_cart_product_url(@product)
    assert_redirected_to edit_shopping_cart_url(user.shopping_cart)
    assert_includes user.shopping_cart.products, @product
  end

end
