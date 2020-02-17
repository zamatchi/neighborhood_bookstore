class CartsController < ApplicationController
  def index
    @cart_items = User.second.cart.cart_products.all
    # @cart_items = current_user.cart
    # @cart_items = current_cart.cart_products
  end
end
