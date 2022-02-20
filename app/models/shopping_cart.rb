class ShoppingCart < ApplicationRecord
  belongs_to :user

  has_many :product_instances

  enum status: [:open, :ordered, :in_progress, :ready_for_delivery, :delivered, :waiting_for_payment, :completed, :canceled]

end
