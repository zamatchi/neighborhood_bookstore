class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @product = Product.find(params[:id])
    if current_user.cart.blank?
      cart = current_user.build_cart
      cart.save
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "登録に成功しました。"
      redirect_to @product
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash[:success] = "商品情報を更新しました。"
      redirect_to @product
    else
      flash.now[:danger] = "商品情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "削除しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "削除に失敗しました。"
      render :show
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :author, :description, :price, :num, :img)
  end
end
