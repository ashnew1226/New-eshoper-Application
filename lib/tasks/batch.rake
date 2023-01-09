namespace :batch do
  desc "TODO"
  task send_messages: :environment do
    UserOrderMailer.daily_order_status.deliver
  end

end
