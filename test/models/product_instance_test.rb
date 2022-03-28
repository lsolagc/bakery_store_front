require "test_helper"

class ProductInstanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should require combination on finalize_order or set_combination' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, quantity: 1, product: products(:one))

    refute pi.save(context: :finalize_order)
    assert_includes pi.errors.details[:combination], {error: :blank}

    refute pi.save(context: :set_combination)
    assert_includes pi.errors.details[:combination], {error: :blank}
  end

  test 'should not require combination on general save' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, quantity: 1, product: products(:one), total_value: 0)
    assert pi.save, "The following errors prevented the save: #{pi.errors.details}"
  end

  test 'should require total_value greater than zero on finalize_order ' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, quantity: 1, product: products(:one))

    refute pi.save(context: :finalize_order)
    assert_includes pi.errors.details[:total_value], {error: :blank}
    assert_includes pi.errors.details[:total_value], {:error=>:not_a_number, :value=>nil}

    pi.total_value = 0

    refute pi.save(context: :finalize_order)
    assert_includes pi.errors.details[:total_value], {:error=>:greater_than, :value=>0, :count=>0}
  end

  test 'should require total_value as number and quantity greater than zero on general save' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, product: products(:one))

    refute pi.save
    assert_includes pi.errors.details[:quantity], {:error=>:blank}
    assert_includes pi.errors.details[:quantity], {:error=>:not_a_number, :value=>nil}

    pi.quantity = 0
    refute pi.save
    assert_includes pi.errors.details[:quantity],{:error=>:greater_than, :value=>0, :count=>0}

    assert_includes pi.errors.details[:total_value],{:error=>:blank}
  end

  test 'should not require total_value greater than zero on general save or set_combination' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, quantity: 1, combination: combinations(:one), product: products(:one), total_value: 0)
    assert pi.save, "The following errors prevented the save: #{pi.errors.details}"
    assert pi.save(context: :set_combination), pi.errors.details
  end

  test 'should update total_value if combination is present' do
    pi = ProductInstance.new(shopping_cart: ShoppingCart.first, quantity: 1, product: products(:one), total_value: 0)

    assert pi.save, "The following errors prevented the save: #{pi.errors.details}"
    assert_equal 0, pi.total_value

    pi.combination = combinations(:one)

    assert_changes 'pi.total_value', from: 0, to: combinations(:one).price do
      assert pi.save, "The following errors prevented the save: #{pi.errors.details}"
    end
  end

end
