class Product < ApplicationRecord
  has_many :combinations
  has_many :kinds, through: :combinations
  has_many :sizes, through: :combinations

  has_many_attached :photos

  accepts_nested_attributes_for :combinations, reject_if: :all_blank, allow_destroy: true

end
