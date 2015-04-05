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

set :output, {:error => 'log/crontab.err.log', :standard => 'log/crontab.log'}

set :environment, :production
env :PATH, ENV['PATH']


every '49 * * * *' do
  rake "twitter:normal"
end

every '31 18-23 * * *' do
  rake "twitter:new"
end

every '07 18-23 * * *' do
  rake "twitter:new"
end

every '*/30 0-2 * * *' do
  rake "twitter:new"
end

every '11 * * * *' do
  rake "twitter:follower"
end

every 1.day, :at => '23:53' do
  rake "niconico:clear"
end
every 1.day, :at => '23:55' do
  rake "youtube:clear"
end
every 1.day, :at => '23:57' do
  rake "youtube:new"
end
every 1.day, :at => '23:59' do
  rake "niconico:new"
end

every 1.day, :at => '0:37' do
  rake "youtube:popular"
end

every 1.day, :at => '0:47' do
  rake "niconico:popular"
end

every 1.day, :at => '18:01' do
  rake "youtube:clear"
end
every 1.day, :at => '18:03' do
  rake "youtube:new"
end

every 1.day, :at => '18:05' do
  rake "youtube:popular"
end

every 1.day, :at => '23:35' do
  rake "patient:add"
end

every 1.day, :at => '0:01' do
  rake "patient:update"
end

every 1.day, :at => '0:24' do
  rake "patient:tweet"
end

every 1.day, :at => '11:34' do
  rake "patient:change_name"
end

every 1.day, :at => '4:01' do
  rake "checkmovie:recent"
end

every 1.day, :at => '0:4' do
  rake "cache:delete_patients"
end

every '32 * * * *' do
  rake "rss:recent"
end

every '17 * * * *' do
  rake "twitter:ad"
end
