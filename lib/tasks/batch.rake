namespace :batch do
  desc "TODO"
  task send_messages: :environment do
    OrderMailer.daily_order_status.deliver
  end

  task week_wishlist: :environment do
    UserMailer.weekly_wishlist.deliver
  end

  task daily_queries: :environment do
    ContactMailer.daily_queries.deliver
  end

end
