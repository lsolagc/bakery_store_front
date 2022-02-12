class CreateCombinations < ActiveRecord::Migration[6.1]
  def change
    create_table :combinations do |t|
      t.references :product, null: false, foreign_key: true
      t.references :kind, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
