# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'
require 'open-uri'
require 'rss'

namespace :rss do
  desc "update rss"
  task :recent => :environment do
    rss = RSS::Parser.parse(Settings.site.blog)
    item = rss.item
    already = Blog.where(link: item.link)
    unless already.present? && already.length > 0
      b = Blog.new(title: item.title, link: item.link, post_at: item.date )
      b.save!
    end
    
    setting_twitter
    content = Blog.where(used: false).order("created_at DESC").first
    if content.present?
      tweet = "【あすみんブログ更新】『" + content.title  + "』" + content.link
      content.update_attributes!(used: true)
      Twitter.update(tweet)
    end
  end

  desc "all rss"
  task :all => :environment do
    rss = RSS::Parser.parse(Settings.site.blog)
    rss.items.each do |item|
      item = Blog.new(title: item.title, link: item.link, used: true, post_at: item.date )
      item.save!
    end
  end



  private
  def setting_twitter
    Twitter.configure do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.oauth_token        = Settings.twitter.oauth_token
      config.oauth_token_secret = Settings.twitter.oauth_token_secret
    end
  end
end
