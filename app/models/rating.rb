class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :score,
    numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 },
    presence: true
    
end
