class ProductInstance < ApplicationRecord
  belongs_to :combination, required: false
  belongs_to :product

  belongs_to :shopping_cart

  delegate :combinations, :name, to: :product
  delegate :price, to: :combination

  before_save :update_total_value, if: -> { self.combination.present? }

  # Callback methods

  def update_total_value
    self.total_value = self.quantity * self.price
  end

end
