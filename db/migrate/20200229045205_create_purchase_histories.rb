class CreatePurchaseHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_histories do |t|
      t.references :user, foreign_key: true, unique: true, null: false

      t.timestamps
    end
  end
end
