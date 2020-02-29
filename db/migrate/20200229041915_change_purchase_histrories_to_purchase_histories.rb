class ChangePurchaseHistroriesToPurchaseHistories < ActiveRecord::Migration[5.2]
  def change
    rename_table :purchase_histrories, :purchase_histories
  end
end