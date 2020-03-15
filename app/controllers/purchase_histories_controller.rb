class PurchaseHistoriesController < ApplicationController
  before_action :exist_purchase_history
  def index
    if current_user.admin?
      @purchase_histories = PurchaseHistoryProduct.all.page(params[:page]).per(25).order('updated_at DESC')
      respond_to do |format|
        format.html
        format.csv do
          histories_csv
        end
      end
    else
      @purchase_histories = current_user.purchase_history.purchase_history_products.page(params[:page]).per(25)
    end
  end

  private

  def exist_purchase_history
    unless current_user.purchase_history
      @products = Product.all
      flash[:success] = "購入履歴はありません"
      redirect_to root_path
    end
  end

  def histories_csv
    current_time = Time.current.to_time.strftime('%Y%m%d%H%M')

    year = current_time[0..3]
    month = current_time[4..5]
    day = current_time[6..7]
    hour = current_time[8..9]
    minute = current_time[10..11]

    csv_date = CSV.generate do |csv|
      csv << ["#{year}年#{month}月#{day}日#{hour}時#{minute}分_注文履歴"]
      csv << []
      csv_column_names = ["注文者", "商品名", "購入数", "金額", "	配達者ID", "購入日"]
      csv << csv_column_names
      @purchase_histories.each do |info|
        csv_column_values = [
          info.user_name,
          info.product_name,
          info.quantity,
          info.price,
          info.delivery_user.to_s,
          info.updated_at.strftime('%Y/%m/%d %H:%M')
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date,filename: "#{current_time}_Purchase_History.csv")
  end
end