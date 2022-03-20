module ProductsHelper
  include ApplicationHelper

  def size_badge(product)
    style = 'badge bg-secondary fs-6 m-1'
    tag = "<span class='#{style}'>#{ product.sizes.pluck(:name).uniq.join(', ') }</span>"
    return tag.html_safe
  end

  def kind_badge(product)
    style = 'badge bg-info fs-6 m-1'
    tag = "<span class='#{style}'>#{ product.kinds.pluck(:name).uniq.join(', ') }</span>"
    return tag.html_safe
  end

  def minimum_price_badge(product)
    style = 'badge bg-primary fs-6 m-1'
    price = number_to_currency(product.combinations.pluck(:price).min)
    tag = "<span class='#{style}'>#{ t('number.currency.price_and_up', price: price ) }</span>"
    return tag.html_safe
  end

end
