# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'

@asumi_tweet = ["阿澄","あすみ","佳奈","アスミ","もこたん"]
namespace :patient do

  desc "update patient level"
  task :update => :environment do
    setting_twitter
    follower = Patient.where(:clear => false)
    follower.each do |f|
      prev_level = f.level
      parameter = {}
      if f.since_id.present?
        parameter = {:id => f.twitter_id.to_i, :since_id => f.since_id.to_i, :count => 200}
      else
        parameter = {:id => f.twitter_id.to_i, :count => 200}
      end
      users_tweet = Twitter.user_timeline(parameter)
      if users_tweet.present?
        asumi_count = 0
        tweet_count = users_tweet.length
        users_tweet.each do |tl|
          asumi_count += asumi_tweet_check(tl.text)
        end
        # ascumi_count cal
        asumi = asumi_calculate(asumi_count, tweet_count)
        f.update_attributes(:level => asumi, :asumi_count => asumi_count, :tweet_count => tweet_count,:since_id => users_tweet.first.id.to_s, :prev_level => prev_level, :clear => false)
      end
    end
  end

  task :tweet => :environment do
    setting_twitter
    patient = Patient.all
    patient.each do |p|
      if p.asumi_count > 0
        tweet = "@" + p.name + " 今日の阿済病進行度は" + p.level.to_s + "だよ。"
        if p.prev_level.present?
          if p.level- p.prev_level >= 0
            tweet = tweet + "昨日に比べて" + (p.level - p.prev_level).to_s + "上がったよ。"
          else
            tweet = tweet + "昨日に比べて" + (p.prev_level - p.level).to_s + "下がったよ"
          end
        end
        tweet = tweet + p.tweet_count.to_s + "ツイート中" + p.asumi_count.to_s + "回も私のこと考えてたでしょ。"
        Twitter.update(tweet)
      end
    end
  end

  task :clear => :environment do
    patient = Patient.all
    patient.each do |p|
      p.update_attributes(:clear => false)
    end
  end
  task :add => :environment do
    setting_twitter
    follower = Twitter.followers
    follower.each do |f|
      patient = Patient.new(:twitter_id => f.id.to_s, :name => f.screen_name)
      patient.save
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
  def asumi_tweet_check(word)
    count = 0
    @asumi_tweet.each do |asumi|
      count += word.scan(/#{asumi}/).length
    end
    return count.to_i
  end
  def asumi_calculate(asumi_count, tweet_count)
    m = asumi_count.to_f/tweet_count.to_f
    m = m * 100
    s = -1
    if m <= 40
      s = 9 * m / 4 - 3 * m * m / 160
    elsif m > 40
      s = Math.min( 100, 30 + 3 * m / 4 )
    end
    return s
  end
end
