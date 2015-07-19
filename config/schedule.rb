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

every '31 9-14 * * *' do
  rake "twitter:new"
end

every '07 9-14 * * *' do
  rake "twitter:new"
end

every '*/30 15-17 * * *' do
  rake "twitter:new"
end

every '11 * * * *' do
  rake "twitter:follower"
end

every 1.day, :at => '14:53' do
  rake "niconico:clear"
end
every 1.day, :at => '14:55' do
  rake "youtube:clear"
end
every 1.day, :at => '14:57' do
  rake "youtube:new"
end
every 1.day, :at => '14:59' do
  rake "niconico:new"
end

every 1.day, :at => '15:37' do
  rake "youtube:popular"
end

every 1.day, :at => '15:47' do
  rake "niconico:popular"
end

every 1.day, :at => '9:01' do
  rake "youtube:clear"
end
every 1.day, :at => '9:03' do
  rake "youtube:new"
end

every 1.day, :at => '9:05' do
  rake "youtube:popular"
end

every 1.day, :at => '14:35' do
  rake "patient:add"
end

every 1.day, :at => '15:01' do
  rake "patient:update"
end

every 1.day, :at => '15:24' do
  rake "patient:tweet"
end

every 1.day, :at => '2:34' do
  rake "patient:change_name"
end

every 1.day, :at => '19:01' do
  rake "checkmovie:recent"
end

every 1.day, :at => '15:4' do
  rake "asumi_level:month_ranking"
end

every '32 * * * *' do
  rake "rss:recent"
end

every '17 * * * *' do
  rake "twitter:ad"
end

every '*/5 * * * *' do
  command "cd /srv/www/asumibot/current && if [ ! -e tmp/pids/userstream.pid ] || ! ps $(cat tmp/pids/userstream.pid) ; then bundle exec rake asumistream:reploy RAILS_ENV=production ; fi"
end
