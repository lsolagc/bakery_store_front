class ShoppingCartsController < InheritedResources::Base

  private

    def shopping_cart_params
      params.require(:shopping_cart).permit()
    end

end
