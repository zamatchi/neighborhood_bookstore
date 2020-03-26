class AddDeliveryUserToPurchaseHistoryProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_history_products, :delivery_user, :string
  end
end
