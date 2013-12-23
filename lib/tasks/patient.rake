# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'
require 'url_expander'
require 'open-uri'

namespace :patient do
  @asumi_tweet = ["阿澄","あすみ","佳奈","アスミ","もこたん","もこちゃ"]

  desc "update patient level"
  task :update => :environment do
    setting_twitter
    follower = Patient.where(:disabled => false)
    follower.each do |f|
      prev_level = f.level
      parameter = {}
      users_tweet = []
      if f.since_id.present?
        i = 0
        begin
          i += 1
          parameter = {:id => f.twitter_id.to_i, :since_id => f.since_id.to_i, :count => 200, :page => i}
          users_per = []
          begin
            users_per = Twitter.user_timeline(parameter)
          rescue
            f.update_attributes(:locked => true)
            next
          end
          f.update_attributes(:locked => false)
          users_tweet = users_tweet + users_per
        end while users_per.length == 200
      else
        parameter = {:id => f.twitter_id.to_i, :count => 200}
        begin
          users_tweet = Twitter.user_timeline(parameter)
        rescue
          f.update_attributes(:locked => true)
          next
        end
        f.update_attributes(:locked => false)
      end
      if users_tweet.present?
        asumi_count = 0
        asumi_word = 0
        tweet_count = users_tweet.length
        users_tweet.each do |tl|
          if asumi_tweet_check(tl.text)
            asumi_count += 1 
            # add asumi_tweet for DB
            asumi_tweet = AsumiTweet.new(patient_id: f.id, tweet: tl.text, tweet_id: tl.id.to_s, tweet_time: tl.created_at.to_s(:db))
            asumi_tweet.save
          end
          tweet = asumi_tweet_count(tl.text)
          asumi_word += tweet
        end
        # ascumi_count cal
        asumi = asumi_calculate(asumi_count, tweet_count)
        f.update_attributes(:level => asumi, :asumi_count => asumi_count, :tweet_count => tweet_count, :asumi_word => asumi_word, :since_id => users_tweet.first.id.to_s, :prev_level => prev_level, :clear => false)
        # asumilevels update
        asumi_levels = AsumiLevel.new(patient_id: f.id, asumi_count: asumi_count, tweet_count: tweet_count, asumi_word: asumi_word)
        asumi_levels.save
      else
        f.update_attributes(:level => 0, :asumi_count => 0, :tweet_count => 0, :asumi_word => 0, :prev_level => prev_level, :clear => false)
        # asumilevels update
        asumi_levels = AsumiLevel.new(patient_id: f.id, asumi_count: 0, tweet_count: 0, asumi_word: 0)
        asumi_levels.save
      end

    end
  end

  task :tweet => :environment do
    setting_twitter
    patient = Patient.avail_rankings
    patient.each_with_index do |p, i|
      tweet = "@" + p.name + " 今日の阿済度は" + p.level.to_s + "%だよ。"
      tweet = tweet + Settings['site']['http'] + 'patients/' + p.id.to_s
      debugger
      Twitter.update(tweet)
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
    follower = Twitter.follower_ids().ids
    patients = Patient.all
    patients.each do |p|
      exist_flg = false
      follower.each do |f|
        exist_flg = true if f.to_s == p.twitter_id
      end
      if !exist_flg
        p.update_attributes(:disabled => true)
      end
    end

    follower.each do |f|
      already = Patient.where(:twitter_id => f.to_s)
      if already.blank?
        user = Twitter.user(f)
        patient = Patient.new(twitter_id: f.to_s, name: user.screen_name, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count, protect: user.protected )
        patient.save
      end
    end
  end

  task :change_name => :environment do
    setting_twitter
    patients = Patient.where(:locked => false)
    patients.each do |p|
      begin
        user = Twitter.user(p.twitter_id.to_i)
      rescue
        p.update_attributes(:locked => true )
        next
      end
      p.update_attributes(name: user.screen_name, protect: user.protected, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count )
      sleep(1)
    end
  end

  private
  def setting_twitter
    Twitter.configure do |config|
      config.consumer_key       = Settings['twitter']['consumer_key']
      config.consumer_secret    = Settings['twitter']['consumer_secret']
      config.oauth_token        = Settings['twitter']['oauth_token']
      config.oauth_token_secret = Settings['twitter']['oauth_token_secret']
    end
  end
  def asumi_tweet_check(word)
    expand_url = ""
    doc = ""
    if word.include?("https:")
      http_url = word.gsub('https:','http:')
      begin
        expand_url = UrlExpander::Client.expand(http_url) if http_url.include?("http:")
      rescue
        expand_url = nil
      end
    else
      begin
        expand_url = UrlExpander::Client.expand(word) if word.include?("http:")
      rescue
        expand_url = nil
      end
    end
    if expand_url.present?
      uri = URI(expand_url)
      begin
        doc = Nokogiri::XML(uri.read).text
      rescue
        doc = "error"
      end
    end
    @asumi_tweet.each do |asumi|
      return true if word.include?(asumi)
      return true if doc.include?(asumi)
    end
    return false
  end
  def asumi_tweet_count(word)
    count = 0
    @asumi_tweet.each do |asumi|
      count += word.scan(/#{asumi}/).length
    end
    return count.to_i
  end
  def asumi_calculate(asumi_count, tweet_count)
    m = asumi_count.to_f/tweet_count.to_f
    m = m * 100
    return m
  end
end
