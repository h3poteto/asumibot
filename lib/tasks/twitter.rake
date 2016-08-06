# coding: utf-8

namespace :twitter do
  desc "normal tweet"
  task :normal => :environment do
    client = TwitterClient.new
    movies_array = []
    [YoutubePopular, NiconicoPopular, NiconicoPopular].each do |object|
      movie = object.where(used: false).sample
      movies_array << movie if movie.present?
    end
    movie = movies_array.sample

    # つぶやき
    movie_info = "【" + movie.title + "】"
    popular_tweet = PopularSerif.all.sample.word + " \n"
    if client.update(popular_tweet + movie_info, movie.url)
      movie.update_attributes!(used: true)
    end
  end

  desc "new asumi movie"
  task :new => :environment do
    include Movies
    client = TwitterClient.new
    movie = TodayYoutube.where(:used => false).sample
    if movie == nil
      movie = TodayNiconico.where(:used => false).sample
    end

    next if movie.blank?
    next if !confirm_db(movie.url)
    # つぶやき
    movie_info = "【" + movie.title + "】"
    new_tweet = NewSerif.all.sample.word + "\n" + "（新着）"
    if client.update( new_tweet + movie_info, movie.url )
      movie.update_attributes!(used: true)
    end
  end

  desc "ad asumi.ch"
  task :ad => :environment do
    schedule = Schedule.where(task: "twitter_ad").first
    now = Time.current
    if schedule.time == nil || now > (schedule.time + 10.hours)
      client = TwitterClient.new
      random = rand(2)
      routes = Rails.application.routes.url_helpers
      if random == 1
        tweet = "作業用あすみんの動画を流し続けてくれるページもあるんです。あるんです！\n" + routes.streaming_movies_url(host: Settings.site.host)
      else
        tweet = "さーて、" + Settings.site.http + "とは！？私のツイートやRT、Favに連携して更新されるサイトだー！"
      end
      client.update(tweet, nil)
      schedule.update_attributes!(time: now)
    end
  end

  desc "follower"
  task :follower => :environment do
    @client = TwitterClient.new
    follower = @client.follower_ids().to_a
    friend = @client.friend_ids().to_a
    outgoing = @client.friendships_outgoing().to_a
    fan = follower - friend - outgoing
    # ユーザが凍結されている場合があり，その場合にはフォローできないので例外処理してやる
    fan.each do |f|
      begin
        @client.follow(f)
      rescue Twitter::Error::NotFound => e
        logger.warn("user: #{f} : #{e}")
      end
    end
  end
end
