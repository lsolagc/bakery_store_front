class ProductsController < InheritedResources::Base
  include ProductsHelper
  before_action :authenticate_user!, only: [:add_to_cart]

  def index
    @search_is_being_made = params[:q].present?
    @q = Product.ransack(params[:q])
    @products = @q.result.uniq
  end

  def add_to_cart
    if product_instance = current_user.shopping_cart.product_instances.detect{|pi| pi.product == set_product }
      product_instance.quantity += 1
      product_instance.save!
    else
      ProductInstance.create!(shopping_cart: current_user.shopping_cart, product: set_product, quantity: 1, total_value: 0)
    end
    redirect_to edit_shopping_cart_path(current_user.shopping_cart)
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_product
      Product.find(params["id"])
    end


end
