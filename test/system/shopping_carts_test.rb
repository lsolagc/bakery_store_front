require "application_system_test_case"

class ShoppingCartsTest < ApplicationSystemTestCase
  setup do
    @shopping_cart = shopping_carts(:one)
  end

  test "visiting the index" do
    user = users(:one)
    sign_in user
    shopping_carts = user.shopping_carts.where.not(status: "open").size
    visit shopping_carts_url
    assert_selector "div", text: ShoppingCart.model_name.human(count: 2), count: shopping_carts
    assert_selector "span.status-badge", count: shopping_carts
    assert_selector "span.payment-status-badge", count: shopping_carts
    assert find_link(I18n.t('navigation.links.show_details'), count: shopping_carts)
  end

  test "editing a shopping cart" do
    user = users(:one)
    sign_in user
    visit shopping_cart_url(@shopping_cart)
    assert find_link(I18n.t('form.product_instance.remove_from_cart'), count: @shopping_cart.product_instances.size)
    assert find_button(I18n.t('form.shopping_cart.button.finalize_order'))
  end

  test "editing an empty shopping cart" do
    user = users(:user_with_empty_shopping_cart)
    sign_in user

    visit shopping_cart_url(user.shopping_cart)
    assert_selector "p", text: I18n.t('form.shopping_cart.is_empty')
  end

  test "finalizing a shopping cart" do
    user = users(:one)
    sign_in user

    visit shopping_cart_url(@shopping_cart)
    click_button(I18n.t('form.shopping_cart.button.finalize_order'))

    assert_selector 'div.alert.alert-danger', text: I18n.t('simple_form.error_notification.default_message')

    select(@shopping_cart.products.first.combinations.first.display_name, from: 'shopping_cart_product_instances_combination')
    fill_in 'shopping_cart_due_date', with: DateTime.current + 2.days
    click_button(I18n.t('form.shopping_cart.button.finalize_order'))

    assert_selector "h1", text: I18n.t('form.headers.show', resource: ShoppingCart.model_name.human, id: @shopping_cart.id)
  end

  test "showing a shopping cart" do
    user = users(:one)
    sign_in user

    shopping_cart = shopping_carts(:not_open_shopping_cart)
    visit shopping_cart_url(shopping_cart)
    assert_selector "h1", text: I18n.t('form.headers.show', resource: ShoppingCart.model_name.human, id: shopping_cart.id)
    assert_selector "span.status-badge"
    assert_selector "span.payment-status-badge"
    assert_selector "a[type='button'].btn.btn-danger", text: I18n.t('form.shopping_cart.button.cancel_order')
  end

end
