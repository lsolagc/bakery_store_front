class AddsDueDateToShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_carts, :due_date, :datetime
  end
end
