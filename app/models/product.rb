class Product < ApplicationRecord
  has_many :combinations
  has_many :kinds, through: :combinations
  has_many :sizes, through: :combinations
end
