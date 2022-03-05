class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shopping_carts
    
  # Instance methods

  def to_s
    self.email
  end

  def shopping_cart
    self.shopping_carts.detect{ |sc| sc.open? } || self.shopping_carts.create!(user: self, status: 'open')
  end
end
