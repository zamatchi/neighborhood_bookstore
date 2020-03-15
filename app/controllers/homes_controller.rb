class HomesController < ApplicationController
  def index
    @initial_value = ActiveSupport::OrderedOptions.new
    @initial_value.author = params[:author]
    @initial_value.name = params[:name]

    if current_user
      if params[:author]
        @products = Product.where("author LIKE ?", "%#{params[:author]}%").page(params[:page]).per(30).order('created_at DESC')
      elsif params[:name]
        @products = Product.where("name LIKE ?", "%#{params[:name]}%").page(params[:page]).per(30).order('created_at DESC')
      else
        @products = Product.all.page(params[:page]).per(30).order('created_at DESC')
      end
    else
      redirect_to new_user_session_path
    end
  end
end