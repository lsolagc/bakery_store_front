module ShoppingCartsHelper

  def status_badge_style(shopping_cart)
    shopping_cart.canceled? ? 'badge bg-danger' : 'badge bg-info'
  end

  def payment_status_badge_style(shopping_cart)
    shopping_cart.paid? ? 'badge bg-success' : 'badge bg-warning'
  end

end
