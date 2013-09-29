# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'
require 'date'

namespace :twitter do
  desc "normal tweet"
  task :normal => :environment do
    setting_twitter
    movies_array = []
    movies_array.push(NiconicoPopular.where(:used => false).sample)
    movies_array.push(YoutubePopular.where(:used => false).sample)
    movies = movies_array.sample
    movie_info = "【" + movies.title + "】" + movies.url
    popular_tweet = PopularSerif.all.sample.word + " \n"
    if update( popular_tweet + movie_info)
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
    movie_info = "【" + movies.title + "】" + movies.url

    new_tweet = NewSerif.all.sample.word + "\n" + "（新着）"
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
      user_name = men.user.screen_name
      next if user_name == Settings['twitter']['user_name']

      # DBアクセス
      movies = nil
      random = rand(2)
      if random == 0
        movies = NiconicoMovie.where(:disabled => false).sample
      else
        movies = YoutubeMovie.where(:disabled => false).sample
        user_id = men.user.id
        db_user = User.where(:twitter_id => user_id.to_i ).first
        if db_user.blank?
          db_user = User.new
          db_user.youtube_movies.push(movies)
          db_user.twitter_id = user_id.to_i
          db_user.screen_name = user_name
          db_user.save
        else
          movies.users.push(db_user)
          movies.save
        end
      end
      movie_info = "【" + movies.title + "】" + movies.url
      tweet = ReplySerif.all.sample.word + " \n"
      update("@" + user_name + " " + tweet + movie_info)
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
