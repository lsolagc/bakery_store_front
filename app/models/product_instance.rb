class ProductInstance < ApplicationRecord
  belongs_to :combination
  belongs_to :product
end
