class Product < ApplicationRecord
  has_many :combinations
  has_many :kinds, through: :combinations
  has_many :sizes, through: :combinations
  has_many :ratings

  has_one_attached :photo

  accepts_nested_attributes_for :combinations, reject_if: :all_blank, allow_destroy: true

  def average_rating
    format("%.1f", self.ratings.map(&:score).sum.to_f / self.ratings.size)
  end

end
