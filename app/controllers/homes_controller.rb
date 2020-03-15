class HomesController < ApplicationController
  def index
    @initial_value = ActiveSupport::OrderedOptions.new
    @initial_value.author = params[:author]
    @initial_value.name = params[:name]

    if current_user
      if params[:author]
        @products = Product.where("author LIKE ?", "%#{params[:author]}%")
      elsif params[:name]
        @products = Product.where("name LIKE ?", "%#{params[:name]}%")
      else
        @products = Product.all
      end
    else
      redirect_to new_user_session_path
    end
  end
end