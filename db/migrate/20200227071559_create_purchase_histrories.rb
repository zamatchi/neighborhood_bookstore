class CreatePurchaseHistrories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_histrories do |t|
      t.references :user, foreign_key: true, index: true, unique: true, null: false

      t.timestamps
    end
  end
end
