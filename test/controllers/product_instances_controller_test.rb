require "test_helper"

class ProductInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_instance = product_instances(:one)
  end

  test "should get set_quantity" do
    get set_quantity_product_instance_url(@product_instance), params: {quantity: 2}, xhr: true
    assert_response :success
    assert_equal 2, @product_instance.reload.quantity
  end

  test "should get set_combination" do
    combination = combinations(:one)
    get set_combination_product_instance_url(@product_instance), params: {combination_id: combination.id}, xhr: true
    assert_response :success
    assert_equal combination, @product_instance.reload.combination
  end

  test 'should not set quantity as nil or zero' do
    assert_no_changes '@product_instance.quantity' do
      get set_quantity_product_instance_url(@product_instance), params: {quantity: 0}, xhr: true
      assert_response :unprocessable_entity

      get set_quantity_product_instance_url(@product_instance), params: {quantity: nil}, xhr: true
      assert_response :unprocessable_entity
    end
  end

  test 'should not set combination if it does not exists' do
    @product_instance.combination = combinations(:one)
    assert_no_changes '@product_instance.combination' do
      get set_combination_product_instance_url(@product_instance), params: {combination_id: 0}, xhr: true
      assert_response :unprocessable_entity

      get set_combination_product_instance_url(@product_instance), params: {combination_id: nil}, xhr: true
      assert_response :unprocessable_entity
    end
  end

  test 'should remove product_instance from shopping_cart' do
    shopping_cart = @product_instance.shopping_cart
    delete product_instance_url(@product_instance)
    assert_redirected_to edit_shopping_cart_path(shopping_cart)
    assert_not_includes shopping_cart.product_instances, @product_instance
  end

end
