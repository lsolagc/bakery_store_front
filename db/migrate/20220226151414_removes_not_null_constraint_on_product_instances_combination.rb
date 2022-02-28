class RemovesNotNullConstraintOnProductInstancesCombination < ActiveRecord::Migration[6.1]
  def change
    change_column_null :product_instances, :combination_id, true
  end
end
