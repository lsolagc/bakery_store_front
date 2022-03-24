require "test_helper"

class ShoppingCartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @open_shopping_cart = shopping_carts(:open_shopping_cart)
    @not_open_shopping_cart = shopping_carts(:not_open_shopping_cart)
  end

  routes = [
    {action: 'new', method: :get, url: '/sizes/new', params: nil},
    {action: 'create', method: :post, url: '/sizes', params: { shopping_cart: {  } }},
    {action: 'destroy', method: :delete, url: '/sizes/1', params: nil},
  ]

  routes.each do |route|
    test "should not have #{route[:action]} route" do
      assert_raises(ActionController::RoutingError) do
        send(route[:method], route[:url], params: route[:params])
      end
    end
  end

  test "should get index" do
    sign_in users(:one)
    get shopping_carts_url
    assert_response :success
  end

  test "should show shopping_cart that is not open" do
    sign_in users(:one)
    ["ordered", "in_progress", "ready_for_delivery", "completed", "canceled"].each do |status|
      @not_open_shopping_cart.send("#{status}!".to_sym)
      get shopping_cart_url(@not_open_shopping_cart)
      assert_response :success
    end
  end

  test 'should redirect to edit if trying to show an open shopping_cart' do
    sign_in users(:one)
    get shopping_cart_url(@open_shopping_cart)
    assert_redirected_to edit_shopping_cart_url(@open_shopping_cart)
  end

  test "should get edit for open shopping_cart" do
    sign_in users(:one)
    get edit_shopping_cart_url(@open_shopping_cart)
    assert_response :success
  end

  test 'should redirect to show if trying to edit a shopping_cart that is not open' do
    sign_in users(:one)
    ["ordered", "in_progress", "ready_for_delivery", "completed", "canceled"].each do |status|
      @not_open_shopping_cart.send("#{status}!".to_sym)
      get edit_shopping_cart_url(@not_open_shopping_cart)
      assert_redirected_to shopping_cart_url(@not_open_shopping_cart)
    end
  end


end
