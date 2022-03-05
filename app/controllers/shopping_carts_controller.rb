class ShoppingCartsController < InheritedResources::Base
  include ShoppingCartsHelper
  
  before_action :authenticate_user!

  def index
    @shopping_carts = ShoppingCart.where.not(status: 'open')
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
    respond_to do |format|
      if @shopping_cart.save(context: :finalize_order)
        @shopping_cart.ordered!
        format.html { redirect_to shopping_cart_path(@shopping_cart) }
        format.json { render :show, status: :created, location: @shopping_cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel_order
    @shopping_cart = ShoppingCart.find(params[:id])
    if @shopping_cart.ordered?
      @shopping_cart.canceled!
      notice = {class: "alert alert-warning", message: "Your order was successfully canceled."}
    else
      notice = {class: "alert alert-danger", message: "Your order has already started being made. Please contact us in order to check if your order is still cancellable."}
    end
    redirect_to shopping_cart_path(@shopping_cart), notice: notice
  end

  private

    def shopping_cart_params
      params.require(:shopping_cart).permit(:due_date)
    end

end
