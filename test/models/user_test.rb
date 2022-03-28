require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'Should create open shopping cart for user if none exists' do
    user = users(:create_shopping_cart_for_user_if_none_exists)

    assert_empty user.shopping_carts.open

    assert_difference 'ShoppingCart.count' do
      shopping_cart = user.shopping_cart
      assert_equal user, shopping_cart.user
    end

  end

  test 'Should not create cart if there is already one open' do
    user = users(:one)

    assert_not_empty user.shopping_carts.open
    assert_no_difference 'ShoppingCart.count' do
      user.shopping_cart
    end
  end

end
