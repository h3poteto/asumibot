# coding: utf-8
require 'url_expander'
require 'open-uri'

namespace :patient do

  desc "update patient level"
  task :update => :environment do
    setting_twitter
    follower = Patient.where(:disabled => false)
    follower.each do |f|
      prev_level = f.level.present? ? f.level : 0
      prev_level_tweet = f.prev_tweet_count.present? ? f.prev_tweet_count : 0
      prev_tweet = f.tweet_count.present? ? f.tweet_count : 0
      prev_asumi = f.asumi_word.present? ? f.asumi_word : 0

      asumi_count = f.asumi_count
      tweet_count = f.tweet_count
      asumi_word = f.asumi_word
      # ascumi_count cal
      asumi = asumi_calculate(asumi_count, tweet_count)
      f.update_attributes(level: asumi, prev_level: prev_level, prev_level_tweet: prev_level_tweet, prev_tweet_count: prev_tweet, prev_asumi_word: prev_asumi, clear: false, tweet_count: 0, asumi_count: 0, asumi_word: 0)
      # asumilevels update
      asumi_levels = AsumiLevel.new(patient_id: f.id, asumi_count: asumi_count, tweet_count: tweet_count, asumi_word: asumi_word)
      asumi_levels.save
    end
  end

  task :tweet => :environment do
    setting_twitter
    patient = Patient.avail_rankings
    patient.each_with_index do |p, i|
      tweet = "@" + p.name + " 今日の阿澄度は" + p.level.to_s + "%だよ。"
      tweet = tweet + Settings.site.http + 'patients/' + p.id.to_s
      @client.update(tweet)
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
    follower = @client.follower_ids.to_a
    patients = Patient.all
    patients.each do |p|
      exist_flg = false
      follower.each do |f|
        exist_flg = true if f.to_i == p.twitter_id.to_i
      end
      if !exist_flg
        p.update_attributes(:disabled => true)
      end
    end

    follower.each do |f|
      already = Patient.where(:twitter_id => f.to_i)
      if already.blank?
        begin
          user = @client.user(f)
          patient = Patient.new(twitter_id: f.to_i, name: user.screen_name, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count, protect: user.protected? )
          patient.save
        rescue
          next
        end
      end
    end
  end

  task :change_name => :environment do
    setting_twitter
    patients = Patient.where(:locked => false)
    patients.each do |p|
      begin
        user = @client.user(p.twitter_id.to_i)
      rescue
        p.update_attributes(:locked => true )
        next
      end
      p.update_attributes(name: user.screen_name, protect: user.protected?, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count )
      sleep(1)
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

  def asumi_calculate(asumi_count, tweet_count)
    if tweet_count == 0
      return 0
    end
    m = asumi_count.to_f/tweet_count.to_f
    m = m * 100
    return m
  end
end
