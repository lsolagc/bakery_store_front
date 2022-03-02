require "test_helper"

class ProductInstancesControllerTest < ActionDispatch::IntegrationTest
  test "should get set_quantity" do
    get product_instances_set_quantity_url
    assert_response :success
  end

  test "should get set_combination" do
    get product_instances_set_combination_url
    assert_response :success
  end
end
