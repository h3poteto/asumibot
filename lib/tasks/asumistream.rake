# coding: utf-8

namespace :asumistream do

  desc "reply userstream"
  task :reply => :environment do
    include Movies

    pid_file = "#{Rails.root}/tmp/pids/userstream.pid"
    File.write(pid_file, $$)
    at_exit { File.delete(pid_file) }
    start_time = Time.current
    TweetStream.configure do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.oauth_token        = Settings.twitter.oauth_token
      config.oauth_token_secret = Settings.twitter.oauth_token_secret
      config.auth_method        = :oauth
    end
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end
    ## for fav event
    client.on_event(:favorite) do |event|
      if event[:event] == "favorite"
        # search user
        user_id = event[:source][:id].to_i
        user = User.find_or_create(event[:source][:screen_name], user_id)

        # find url
        expanded_urls = []
        event[:target_object][:entities][:urls].each do |url|
          expanded_urls.push(url[:expanded_url])
        end
        expanded_urls.each do |expand_url|
          # search object
          movie_object = find_movie(expand_url)
          # add object
          if movie_object.present?
            movie_object.fav_users.push(user)
            movie_object.save!
          end
        end
      end
    end

    ## read timeline
    client.userstream do | status |
      ## 阿澄度計測用処理
      body_data = {
        user_id: status.user.id.to_s,
        text: status.text,
        id: status.id.to_s,
        created_at: status.created_at.to_s(:local)
      }
      PatientWorker.perform_async(body_data)
      ## タイムライン処理
      if ( include_asumich?(status.urls) && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
        # search user
        user_id = status.user.id.to_i
        user = User.find_or_create(status.user.screen_name, user_id)

        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          movie_object = find_movie_for_asumich(expand_url)
          # add object
          if movie_object.present?
            movie_object.rt_users.push(user)
            movie_object.save!
          end
        end
      elsif (status.in_reply_to_user_id != nil) && (!status.text.include?("RT")) && (!status.text.include?("QT")) && (status.user.screen_name != Settings.twitter.user_name) && (status.text.include?("@"+Settings.twitter.user_name))
        ## reply
        puts status.user.screen_name
        puts status.text

        # userstreamなのでlastはチェックいらない
        last_men = LastData.where(:category => "mention").first
        men = status
        user_name = men.user.screen_name
        last_men.tweet_id = men.id.to_s
        last_men.save

        movie = find_random

        movie_info = "【" + movie.title + "】"
        tweet = ReplySerif.all.sample.word + " \n"
        TwitterClient.new.update("@" + user_name + " " + tweet + movie_info, movie.url)

      elsif ((status.text.include?("RT") || status.text.include?("QT")) && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
        ## for RT
        # search user
        user_id = status.user.id.to_i
        user = User.first_or_create(screen_name: status.user.screen_name, twitter_id: user_id)

        # find url
        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          # search object
          movie_object = find_movie(expand_url)
          # add object
          if movie_object.present?
            movie_object.rt_users.push(user)
            movie_object.save!
          end
        end
      end

      ## 時間が過ぎたらプロセスを殺す
      end_time = start_time + 1.day
      if Time.current > end_time
        exit
      end
    end
  end
end
