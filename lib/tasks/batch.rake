namespace :batch do
  desc "TODO"
  task send_messages: :environment do
    UserOrderMailer.daily_order_status.deliver
  end

  task week_wishlist: :environment do
    UserMailer.weekly_wishlist.deliver
  end

end
