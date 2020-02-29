class DropTablePurchaseHistrories < ActiveRecord::Migration[5.2]
  def change
    drop_table :purchase_histrories
  end
end
