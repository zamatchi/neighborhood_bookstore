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
      @purchase_histories = current_user.purchase_history.purchase_history_products.page(params[:page]).per(25).order('updated_at DESC')
    end
  end

  def range
    if current_user.admin?
      if Date.valid_date?(params["start_date(1i)"]&.to_i, params["start_date(2i)"]&.to_i, params["start_date(3i)"]&.to_i) \
        && Date.valid_date?(params["end_date(1i)"]&.to_i, params["end_date(2i)"]&.to_i, params["end_date(3i)"]&.to_i)
      
        start_date = Date.new(params["start_date(1i)"]&.to_i, params["start_date(2i)"]&.to_i, params["start_date(3i)"]&.to_i)
        end_date = Date.new(params["end_date(1i)"]&.to_i, params["end_date(2i)"]&.to_i, params["end_date(3i)"]&.to_i)

        unless start_date <= end_date
          flash[:success] = "終了日を開始日より後の日付にしてください。"
          @purchase_histories = PurchaseHistoryProduct.all.page(params[:page]).per(25).order('updated_at DESC')
        else
          range = start_date.beginning_of_day..end_date.end_of_day
          @purchase_histories = PurchaseHistoryProduct.where(updated_at: range).page(params[:page]).per(25).order('updated_at DESC')
        end

        respond_to do |format|
          format.html
          format.csv do
            histories_csv
          end
        end
      else
        @purchase_histories = PurchaseHistoryProduct.all.page(params[:page]).per(25).order('updated_at DESC')
        flash[:success] = "存在する日付を選択して下さい。"
      end
    else
      @purchase_histories = current_user.purchase_history.purchase_history_products.page(params[:page]).per(25).order(updated_at: "DESC")
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