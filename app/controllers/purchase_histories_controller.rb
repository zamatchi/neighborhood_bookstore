class PurchaseHistoriesController < ApplicationController
  before_action :exist_purchase_history
  def index
    @purchase_histories = current_user.purchase_history.purchase_history_products
  end

  private

  def exist_purchase_history
    unless current_user.purchase_history
      @products = Product.all
      flash[:success] = "購入履歴はありません"
      redirect_to root_path
    end
  end
end