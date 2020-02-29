class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def total_price
    price_array = []
    products.zip(cart_products) do |cart_item, order_num|
      price_array.push(cart_item.price * order_num.quantity)
    end
    return price_array.sum
  end
end