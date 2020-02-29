class RenameNumColumnToCartProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_products, :num, :quantity
  end
end