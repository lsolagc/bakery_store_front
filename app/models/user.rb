class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shopping_carts

  validates :name, :surname, presence: true

  # Instance methods

  def display_name
    self.full_name.presence || self.email
  end

  def full_name
    "#{self.name} #{self.surname}"
  end

  def shopping_cart
    self.shopping_carts.detect{ |sc| sc.open? } || self.shopping_carts.create!(user: self, status: 'open')
  end
end
