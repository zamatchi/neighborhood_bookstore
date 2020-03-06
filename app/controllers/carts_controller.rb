class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :exist_cart, only:[:index]

  def index
    @cart_items = current_user.cart.products
    @order_nums = current_user.cart.cart_products
    @total_price = current_user.cart.total_price
  end

  def add
    if params[:cart_product][:quantity].to_i <= 0
      flash[:danger] = "購入数を0より大きい数で指定してください。"
      redirect_back(fallback_location: root_path) and return
    end
    if params[:cart_product][:product_num].to_i >= params[:cart_product][:quantity].to_i
      if current_user.cart.cart_products.find_by(product_id: params[:cart_product][:product_id])
        @cart_product = current_user.cart.cart_products.find_by(product_id: params[:cart_product][:product_id])
        @cart_product.quantity += params[:cart_product][:quantity].to_i
      else
        @cart_product = current_user.cart.cart_products.build(product_id: params[:cart_product][:product_id])
        @cart_product.quantity = params[:cart_product][:quantity].to_i
      end

      if @cart_product.save
        flash[:success] = "カートに追加しました。"
        redirect_to root_path
      else
        flash[:danger] = "カートの追加に失敗しました。"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:danger] = "在庫数より少ない数を指定してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @product = Product.find_by_hashid(params[:id])
    @cart_item = current_user.cart.products.find_by(id: @product.id)
    @cart = current_user.cart.cart_products.find_by(product_id: @product.id)
  end

  def update
    if params[:cart_product][:quantity].to_i <= 0
      flash[:danger] = "購入数を0より大きい数で指定してください。"
      redirect_back(fallback_location: root_path) and return
    end
    @cart_product = current_user.cart.cart_products.find_by(product_id: params[:cart_product][:product_id])
    @cart_item = current_user.cart.products.find_by(id: params[:cart_product][:product_id])
    if @cart_item.num >= params[:cart_product][:quantity].to_i
      @cart_product.quantity =  params[:cart_product][:quantity].to_i
      @cart_product.save
      flash[:success] = "購入数を変更しました。"
      redirect_to carts_path
    else
      flash[:danger] = "在庫数より少ない数を指定してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @product = Product.find_by_hashid(params[:id])
    cart_product = current_user.cart.cart_products.find_by(product_id: @product.id)
    cart_product.destroy
    redirect_to carts_path
  end

  private

  def exist_cart
    unless current_user.cart
      @products = Product.all
      flash[:success] = "カートはからの状態です。"
      redirect_to root_path
    end
  end
end