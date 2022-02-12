class CreateProductInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :product_instances do |t|
      t.references :combination, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end
end
