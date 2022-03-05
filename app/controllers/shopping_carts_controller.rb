class ShoppingCartsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    @shopping_carts = ShoppingCart.ordered_or_further
  end

  def show
    @shopping_cart = ShoppingCart.find(params[:id])
    if @shopping_cart.open?
      redirect_to edit_shopping_cart_path(@shopping_cart) 
      return
    end
  end
  
  def edit
    @shopping_cart = ShoppingCart.find(params[:id])
    if !@shopping_cart.open?
      redirect_to shopping_cart_path(@shopping_cart) 
      return
    end
  end

  def finalize_order
    @shopping_cart = current_user.shopping_cart
    @shopping_cart.attributes = shopping_cart_params.to_h
    @shopping_cart.ordered!
    redirect_to shopping_cart_path(@shopping_cart)
  end

  private

    def shopping_cart_params
      params.require(:shopping_cart).permit(:due_date)
    end

end
