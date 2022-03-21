class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @rating = Rating.new(
      product: Product.find(rating_params[:product_id]),
      user: current_user,
      score: rating_params[:rating][:score],
      comment: rating_params[:rating][:comment],
    )
    respond_to do |format|
      if @rating.save
        format.json { render :show, status: :created }
        format.js
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def rating_params
    params.permit(:product_id, rating: [:score, :comment])
  end

end
