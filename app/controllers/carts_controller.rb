class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @cart_items = current_user.cart.products
    @order_nums = current_user.cart.cart_products
  end
end