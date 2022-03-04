class ShoppingCart < ApplicationRecord
  belongs_to :user

  has_many :product_instances

  enum status: [:open, :ordered, :in_progress, :ready_for_delivery, :delivered, :waiting_for_payment, :completed, :canceled]

  before_save :update_total_value

  validates :due_date, presence: true, if: -> { self.product_instances.present? && self.product_instances.all?{ |pi| pi.combination.present? && pi.total_value.present? } }

  # Callback methods

  def update_total_value
    self.total_value = self.product_instances.pluck(:total_value).compact.reduce(:+)
  end

end
