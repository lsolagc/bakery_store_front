class Combination < ApplicationRecord
  belongs_to :product
  belongs_to :kind
  belongs_to :size
end
