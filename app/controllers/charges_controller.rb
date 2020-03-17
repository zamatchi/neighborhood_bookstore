class ChargesController < ApplicationController

  def create
    price_array = []
    purchase_all_info = []
    
    cart_item_ids = params[:product_ids].split(",").map(&:to_i)
    cart_prices = cart_item_ids.map do |cart_item_id|
      product = current_user.cart.products.find(cart_item_id)
      cart_item = current_user.cart.cart_products.find_by(product_id: cart_item_id)
      
      purchase_price = product.price * cart_item.quantity
      price_array.push(purchase_price)

      
      purchase_info = [cart_item_id, product.name, cart_item.quantity, purchase_price]
      purchase_all_info.push(purchase_info)
    end

    tatal_price = price_array.sum
    
    if Rails.env.production?
      Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']
    end

    if Rails.env.development?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end

    # トークンはCheckoutまたはElementsを使用して作成されます！
    # フォームから送信された支払いトークンIDを取得します
    token = params[:stripeToken]
    charge = Stripe::Charge.create({
        amount: tatal_price,
        currency: 'jpy',
        description: 'Example charge',
        source: token
    })

    ActiveRecord::Base.transaction do

      # 購入履歴の作成
      unless current_user.purchase_history
        current_user.purchase_history = current_user.build_purchase_history
      end

      purchase_all_info.each do |purchase_info|        
        purchase_history = current_user.purchase_history.purchase_history_products.create!(user_name: current_user.name, product_id: purchase_info[0], product_name: purchase_info[1], quantity: purchase_info[2], price: purchase_info[3], delivery_user: params[:delivery_user])
        product = Product.find(purchase_info[0])
        product.num -= purchase_info[2]
        product.save
      end


      # カートの削除
      cart_products = current_user.cart.cart_products
      cart_products.each(&:destroy!)
    end
      flash[:success] = '決済に成功しました。'
      redirect_to root_path
    rescue => e
      flash[:danger] = '決済に失敗しました。'
      redirect_back(fallback_location: root_path)
  end
end