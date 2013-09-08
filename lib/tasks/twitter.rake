# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'
require 'date'

namespace :twitter do
  desc "normal tweet"
  task :normal => :environment do
    setting_twitter
    movies = YoutubePopular.where(:used => false).sample
    movie_info = "【" + movies.title + "】" + movies.url
    popular_tweet = "今、阿澄病患者に人気な動画だよ \n"
    if update( popular_tweet + movie_info)
      movies.used = true
      movies.save
    end
  end
  
  desc "new asumi movie"
  task :new => :environment do
    setting_twitter
    movies = TodayYoutube.where(:used => false).sample
    movie_info = "【" + movies.title + "】" + movies.url
    new_tweet = "今日の新着あすみん動画はこんなの \n"
    if update( new_tweet + movie_info )
      movies.used = true
      movies.save
    end
  end

  desc "reply tweet"
  task :reply => :environment do
    setting_twitter
    mention = Twitter.mentions
    last_men = LastData.where(:category => "mention").first
    mention.each do |men|
      break if men.id.to_s == last_men.tweet_id.to_s
      user = men.user.screen_name
      next if user == Settings['twitter']['user_name']
      movies = YoutubeMovie.where(:disabled => false).sample
      movie_info = "【" + movies.title + "】" + movies.url
      tweet = "おすすめな阿澄病治療動画だよ！ \n"
      update("@" + user + " " + tweet + movie_info)
    end
    last_men.tweet_id = mention[0].id.to_s
    last_men.save
  end

  desc "follower"
  task :follwer => :environment do
    setting_twitter
    follower = Twitter.follower_ids().ids
    friend = Twitter.friend_ids().ids
    fan = follow - friend
    fan.each do |f|
      Twitter.follow(f)
    end
  end
  
  def setting_twitter
    Twitter.configure do |config|
      config.consumer_key       = Settings['twitter']['consumer_key']
      config.consumer_secret    = Settings['twitter']['consumer_secret']
      config.oauth_token        = Settings['twitter']['oauth_token']
      config.oauth_token_secret = Settings['twitter']['oauth_token_secret']
    end
  end
  def update(tweet)
    begin
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      Twitter.update(tweet.chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : " + e.message + ">>"
      return false
    end
    return true
  end
end
