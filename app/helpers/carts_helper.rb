module CartsHelper
  def coupons_price
    if session[:coupon].present?
      session[:cart_hash][:products_price] - session[:coupon]["percent_off"].to_i
    end
  end
end
