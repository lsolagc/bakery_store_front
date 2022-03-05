class ProductInstance < ApplicationRecord
  belongs_to :combination, required: false
  belongs_to :product

  belongs_to :shopping_cart

  delegate :combinations, :name, to: :product
  delegate :price, to: :combination

  validates :combination, presence: true, on: :finalize_order
  
  validates :quantity, presence: true
  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  validates :total_value, presence: true
  validates_numericality_of :total_value, greater_than: 0, on: :finalize_order

  before_save :update_total_value, if: -> { self.combination.present? }

  # Callback methods

  def update_total_value
    self.total_value = self.quantity * self.price
  end

  # Instance methods

  def to_s
    "#{product.name} - #{combination}"
  end

end
