class PurchaseHistoriesController < ApplicationController
  def index
    @purchase_histories = current_user.purchase_history.purchase_history_products
  end
end
