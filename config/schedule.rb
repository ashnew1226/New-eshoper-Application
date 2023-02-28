# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
set :environment, "development"
env :PATH, ENV['PATH']
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 1.day do
  rake 'batch:send_messages'
end

every 1.day do
  rake 'batch:daily_queries'
end
every 7.day do
    rake 'batch:week_wishlist'
end
# Learn more: http://github.com/javan/whenever
