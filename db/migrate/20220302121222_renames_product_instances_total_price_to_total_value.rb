class RenamesProductInstancesTotalPriceToTotalValue < ActiveRecord::Migration[6.1]
  def change
    rename_column :product_instances, :total_price, :total_value
  end
end
