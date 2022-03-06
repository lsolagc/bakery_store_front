class Combination < ApplicationRecord
  belongs_to :product
  belongs_to :kind
  belongs_to :size

  validates :price, presence: true

  # Instance methods
  def display_name
    "#{self.kind.name} (#{self.size.name})"
  end

end
