require "test_helper"

class ShoppingCartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should not be saved without due_date if being finalized' do
    shopping_cart = shopping_carts(:one)

    assert_not shopping_cart.save(context: :finalize_order)
    assert_includes shopping_cart.errors.attribute_names, :due_date
    assert_includes shopping_cart.errors.errors.map(&:type), :blank
  end

  test 'should not be saved with due_date sooner than 24 hours in the future' do
    shopping_cart = shopping_carts(:one)

    shopping_cart.due_date = DateTime.current + 30.minutes
    assert_not shopping_cart.save(context: :finalize_order)
    assert_includes shopping_cart.errors.attribute_names, :due_date
    assert_includes shopping_cart.errors.errors.map(&:type), :too_soon
  end

  test 'should be saved if not being finalized' do
    shopping_cart = shopping_carts(:one)

    assert shopping_cart.save
  end

end
