class CreateShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.float :total_value

      t.timestamps
    end

    add_column :product_instances, :shopping_cart_id, :integer, foreign_key: true
    add_index :product_instances, :shopping_cart_id
  end
end
