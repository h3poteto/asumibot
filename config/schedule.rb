# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, 'log/crontab.log'

set :environment, :production

every 2.minutes do
  rake "twitter:reply"
end

every '48 * * * *' do
  rake "twitter:normal"
end

every '32 18-23 * * *' do
  rake "twitter:new"
end

every '*/30 0-2 * * *' do
  rake "twitter:new"
end

every 1.day, :at => '23:55' do
  rake "youtube:clear"
  rake "youtube:popular"
  rake "youtube:new"
end

every 1.day, :at => '23:59' do
  rake "niconico:clear"
  rake "niconico:popular"
  rake "niconico:new"
end

