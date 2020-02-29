class DropPurchaseHistoryProduct < ActiveRecord::Migration[5.2]
  def change
    drop_table :purchase_history_products
  end
end
