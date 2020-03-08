class HomesController < ApplicationController
  def index
    if current_user
      @products = Product.all
    else
      redirect_to new_user_session_path
    end
  end
end