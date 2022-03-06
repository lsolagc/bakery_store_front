class AddPaymentStatusToShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_carts, :payment_status, :integer, default: 0
  end
end
