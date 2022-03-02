class Combination < ApplicationRecord
  belongs_to :product
  belongs_to :kind
  belongs_to :size

  validates :price, presence: true

  # Instance methods
  def to_s
    "#{self.kind.name} (#{self.size.name})"
  end

end
