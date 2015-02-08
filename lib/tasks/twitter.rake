# coding: utf-8

require 'date'
require 'url_expander'
require 'open-uri'

namespace :twitter do
  desc "normal tweet"
  task :normal => :environment do
    setting_twitter
    movies_array = []
    movies_array.push(NiconicoPopular.where(:used => false).sample)
    movies_array.push(NiconicoPopular.where(:used => false).sample)
    movies_array.push(YoutubePopular.where(:used => false).sample)
    movies = movies_array.sample

    # つぶやき
    movie_info = "【" + movies.title + "】"
    popular_tweet = PopularSerif.all.sample.word + " \n"
    if update( popular_tweet + movie_info, movies.url)
      movies.used = true
      movies.save
    end
  end

  desc "new asumi movie"
  task :new => :environment do
    setting_twitter
    movies = TodayYoutube.where(:used => false).sample
    if movies == nil
      movies = TodayNiconico.where(:used => false).sample
    end

    next if movies.blank?
    next if !confirm_db(movies.url)
    # つぶやき
    movie_info = "【" + movies.title + "】"
    new_tweet = NewSerif.all.sample.word + "\n" + "（新着）"
    if update( new_tweet + movie_info, movies.url )
      movies.used = true
      movies.save
    end
  end

  desc "ad asumi.ch"
  task :ad => :environment do
    schedule = Schedule.where(task: "twitter_ad").first
    now = Time.now
    if schedule.time == nil || now > (schedule.time + 10.hours)
      setting_twitter
      random = rand(2)
      routes = Rails.application.routes.url_helpers
      if random == 1
        tweet = "作業用あすみんの動画を流し続けてくれるページもあるんです。あるんです！\n" + routes.streaming_movies_url(host: Settings.site.host)
      else
        tweet = "さーて、" + Settings.site.http + "とは！？私のツイートやRT、Favに連携して更新されるサイトだー！"
      end
      @client.update(tweet)
      schedule.update_attributes!(time: now)
    end
  end

  desc "follower"
  task :follower => :environment do
    setting_twitter
    follower = @client.follower_ids().ids
    friend = @client.friend_ids().ids
    outgoing = @client.friendships_outgoing().ids
    fan = follower - friend - outgoing
    fan.each do |f|
      @client.follow(f)
    end
  end

  private

  def setting_twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.access_token        = Settings.twitter.oauth_token
      config.access_token_secret = Settings.twitter.oauth_token_secret
    end
  end
  def update(tweet, url)
    begin
      if (tweet + url).length > 140
        tweet = tweet[0..(130 - url.length)].to_s + "...\n" + url
      else
        tweet += url
      end
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      @client.update(tweet.chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : " + e.message + ">>"
      return false
    end
    return true
  end
end
