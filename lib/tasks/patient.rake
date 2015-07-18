# coding: utf-8
require 'url_expander'
require 'open-uri'

namespace :patient do

  desc "update patient level"
  task :update => :environment do
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
      asumi = f.asumi_calculate
      # patientの情報を今日の分に書き換える
      f.update_attributes(level: asumi, prev_level: prev_level, prev_level_tweet: prev_level_tweet, prev_tweet_count: prev_tweet, prev_asumi_word: prev_asumi, clear: false, tweet_count: 0, asumi_count: 0, asumi_word: 0)
      # asumilevelを新規作成
      AsumiLevel.create(patient_id: f.id, asumi_count: asumi_count, tweet_count: tweet_count, asumi_word: asumi_word)
    end
  end

  task :tweet => :environment do
    client = TwitterClient.new
    patient = Patient.avail_rankings
    patient.each_with_index do |p, i|
      tweet = "@" + p.name + " 今日の阿澄度は" + p.level.to_s + "%だよ。"
      tweet = tweet + Settings.site.http + 'patients/' + p.id.to_s
      client.update(tweet, nil)
    end
  end

  task :clear => :environment do
    patient = Patient.all
    patient.each do |p|
      p.update_attributes(:clear => false)
    end
  end
  task :add => :environment do
    client = TwitterClient.new
    follower = client.follower_ids.to_a
    patients = Patient.all
    patients.each do |p|
      exist_flg = true
      follower.each do |f|
        exist_flg = false if f.to_i == p.twitter_id.to_i
      end
      p.update_attributes!(disabled: exist_flg)
    end

    follower.each do |f|
      already = Patient.where(:twitter_id => f.to_i)
      if already.blank?
        begin
          user = client.user(f)
          patient = Patient.new(twitter_id: f.to_i, name: user.screen_name, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count, protect: user.protected? )
          patient.save
        rescue
          next
        end
      end
    end
  end

  task :change_name => :environment do
    client = TwitterClient.new
    patients = Patient.where(:locked => false)
    patients.each do |p|
      user = nil
      begin
        user = client.user(p.twitter_id.to_i)
      rescue
        p.update_attributes(:locked => true )
        next
      end
      p.update_attributes(name: user.screen_name, protect: user.protected?, nickname: user.name, description: user.description, icon: user.profile_image_url, friend: user.friends_count, follower: user.followers_count, all_tweet: user.statuses_count)
      sleep(1)
    end
  end
end
