class ShoppingCart < ApplicationRecord
  belongs_to :user

  has_many :product_instances

  enum status: [:open, :ordered, :in_progress, :ready_for_delivery, :completed, :canceled]
  enum payment_status: [:waiting_for_payment_confirmation, :paid]

  before_save :update_total_value

  validate :validate_product_instances, on: :finalize_order
  validates :due_date, presence: true, on: :finalize_order
  validate  :due_date_minimum_time, on: :finalize_order

  # Callback methods

  def validate_product_instances
    return if self.product_instances.all?{ |pi| pi.valid?(:finalize_order)}
    self.errors.add(:product_instances, 'are invalid')
  end

  def due_date_minimum_time
    self.errors.add(:due_date, 'must be at least 24 hours in the future') if self.due_date.present? && self.due_date < (DateTime.current + 1.day).at_beginning_of_minute
  end

  def update_total_value
    self.total_value = self.product_instances.pluck(:total_value).compact.reduce(:+)
  end

  # Instance methods

  def disabled_inputs?
    !editable?
  end

  def editable?
    self.open?
  end

  def cancellable_by_owner?
    self.ordered?
  end

end
