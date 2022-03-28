require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: Product.model_name.human(count: 2).capitalize
    assert_selector "form.product_search" # should have search form

    assert_selector "div.product", count: Product.count

    all("div.product").each do |element|
      image_or_placeholder_text = element.all("div.col > img.thumbnail").first || element.find('div.col', text: I18n.t('activerecord.attributes.product.photo.none'))
      assert image_or_placeholder_text
      assert element.find_link I18n.t('navigation.links.show')
      assert element.find_link I18n.t('navigation.links.add_to_cart')
    end
  end

  test "showing a product" do
    visit product_url(@product)

    assert_selector "span", text: @product.name
    assert find_link I18n.t('navigation.links.add_to_cart')
  end

  test "adding a product to the shopping cart" do
    user = users(:one)
    sign_in user

    visit product_url(@product)
    click_link I18n.t('navigation.links.add_to_cart')
    assert_selector "h1", text: I18n.t('form.headers.edit', resource: ShoppingCart.model_name.human)
    assert_selector "div", text: @product.name
  end

end
