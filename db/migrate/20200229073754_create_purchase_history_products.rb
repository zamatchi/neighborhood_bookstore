class CreatePurchaseHistoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_history_products do |t|
      t.string :user_name
      t.string :product_name
      t.integer :quantity
      t.integer :price
      t.references :product, foreign_key: true, null: false
      t.references :purchase_history, foreign_key: true, null: false

      t.timestamps
    end
  end
end