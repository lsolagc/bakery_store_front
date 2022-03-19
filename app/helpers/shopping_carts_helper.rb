module ShoppingCartsHelper
  include ApplicationHelper

  def status_badge(shopping_cart)
    style = shopping_cart.canceled? ? 'badge bg-danger' : 'badge bg-info'
    tag = "<span class='#{style}'>#{t("activerecord.attributes.shopping_cart.status.#{shopping_cart.status}")}</span>"
    return tag.html_safe
  end

  def payment_status_badge(shopping_cart)
    style = shopping_cart.paid? ? 'badge bg-success' : 'badge bg-warning'
    tag = "<span class='#{style}'>#{t("activerecord.attributes.shopping_cart.payment_status.#{shopping_cart.payment_status}")}</span>"
    return tag.html_safe
  end

end
