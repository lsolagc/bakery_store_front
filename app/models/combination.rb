class Combination < ApplicationRecord
  belongs_to :product
  belongs_to :kind
  belongs_to :size

  validates :price, presence: true
end
