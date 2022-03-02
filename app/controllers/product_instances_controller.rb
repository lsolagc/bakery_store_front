class ProductInstancesController < ApplicationController
  before_action :set_product_instance
  
  def set_quantity
    @product_instance.quantity = product_instance_params['quantity'].to_i
    respond_to do |format|
      if @product_instance.save
        format.json { render :set_quantity, status: :ok }
        @product_instance.shopping_cart.save!
      else
        format.json { render json: @product_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_combination
    @product_instance.combination = Combination.find(product_instance_params['combination_id'])
    respond_to do |format|
      if @product_instance.save
        format.json { render :set_combination, status: :ok }
        @product_instance.shopping_cart.save!
      else
        format.json { render json: @product_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_instance.destroy
    @product_instance.shopping_cart.save!
    redirect_to edit_shopping_cart_path(@product_instance.shopping_cart)
  end

  private

    def product_instance_params
      params.permit(:id, :combination_id, :quantity)
    end

    def set_product_instance
      @product_instance = ProductInstance.find(product_instance_params['id'])
    end

end
