module ShoppingCartsHelper
    
  def status_badge_style(shopping_cart)
    case shopping_cart.status
    when /canceled/
      'badge bg-danger'
    else
      'badge bg-info'
    end
  end

end
