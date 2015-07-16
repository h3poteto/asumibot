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
        user_id = event[:source][:id]
        user = User.where(twitter_id: user_id)
        if user.blank?
          new_user = User.new(screen_name: event[:source][:screen_name], twitter_id: user_id.to_i)
          new_user.save
          user = new_user
        else
          user = user.first
        end

        # find url
        expanded_urls = []
        event[:target_object][:entities][:urls].each do |url|
          expanded_urls.push(url[:expanded_url])
        end
        expanded_urls.each do |expand_url|
          # search object
          if expand_url.to_s.include?("youtube")
            movie_object = YoutubeMovie.where(url: expand_url.to_s).first
          elsif expand_url.to_s.include?("nicovideo")
            movie_object = NiconicoMovie.where(url: expand_url.to_s).first
          end
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
      PatientJob.perform_later(status.user.id.to_i, status.text, status.id.to_s, status.created_at.to_s(:db))
      ## タイムライン処理
      if (status.urls.any?{|w| w.expanded_url.to_s.include?("/movies/show_")} && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
        # search user
        user_id = status.user.id.to_i
        user = User.where(twitter_id: user_id)
        if user.blank?
          new_user = User.new(screen_name: status.user.screen_name, twitter_id: user_id)
          new_user.save
          user = new_user
        else
          user = user.first
        end

        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          if expand_url.to_s.include?("show_youtube")
            s = expand_url.to_s.index("show_youtube/")
            id = expand_url.to_s[(s+("show_youtube/").length)..200].to_i
            movie_object = YoutubeMovie.find(id)
          elsif expand_url.to_s.include?("show_niconico")
            s = expand_url.to_s.index("show_niconico/")
            id = expand_url.to_s[(s+("show_niconico/").length)..200].to_i
            movie_object = NiconicoMovie.find(id)
          end
          # add object
          if movie_object.present?
            movie_object.rt_users.push(user)
            movie_object.save!
          end
        end
      elsif (status.in_reply_to_user_id != nil) && (!status.text.include?("RT")) && (!status.text.include?("QT")) && (status.user.screen_name != Settings.twitter.user_name) && (status.text.include?("@"+Settings.twitter.user_name))
        puts status.user.screen_name
        puts status.text
        puts "\n"

        # userstreamなのでlastはチェックいらない
        last_men = LastData.where(:category => "mention").first
        men = status
        user_name = men.user.screen_name
        last_men.tweet_id = men.id.to_s
        last_men.save

        # DBアクセス
        movie = nil
        begin
          random = rand(4)
          if random == 1
            movie = YoutubeMovie.where(:disabled => false).sample
          else
            movie = NiconicoMovie.where(:disabled => false).sample
          end

        end while !confirm_db(movie.url)

        movie_info = "【" + movie.title + "】"
        tweet = ReplySerif.all.sample.word + " \n"
        TwitterClient.new.update("@" + user_name + " " + tweet + movie_info, movie.url)

      elsif ((status.text.include?("RT") || status.text.include?("QT")) && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
        ## for RT
        # search user
        user_id = status.user.id.to_i
        user = User.where(twitter_id: user_id)
        if user.blank?
          new_user = User.new(screen_name: status.user.screen_name, twitter_id: user_id)
          new_user.save
          user = new_user
        else
          user = user.first
        end

        # find url
        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          # search object
          if expand_url.to_s.include?("youtube")
            movie_object = YoutubeMovie.where(url: expand_url.to_s).first
          elsif expand_url.to_s.include?("nicovideo")
            movie_object = NiconicoMovie.where(url: expand_url.to_s).first
          end
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
