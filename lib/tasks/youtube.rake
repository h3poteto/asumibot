# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = 'http://gdata.youtube.com/feeds/api/videos?vq='
keywords = URI.encode('阿澄佳奈')

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do

    options = '&orderby=published&time=today'

    uri = URI(URL + keywords + options )
    search_youtube(uri)
  end

  desc "all youtube movie get"
  task :all => :environment do
  end
  
  desc "popular youtube movie get"
  task :popular => :environment do
    options = '&orderby=published'
    uri = URI(URL + keywords + options )
    doc = Nokogiri::XML(uri.read)
    i = 1
    doc.search('entry').each do |entry|
      puts entry.search('title').text
      puts entry.xpath('media:group/media:player').first['url']
      puts
      new_data = YoutubePopular.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], priority: i)
      if new_data.save
        i += 1
      else
        p "save error"
      end
    end
  end

  desc "clear db"
  task :clear => :environment do
    YoutubePopular.delete_all(["created_at < ?","Today"])
  end

  def search_youtube(uri)
    doc = Nokogiri::XML(uri.read)
    doc.search('entry').each do |entry|
      puts entry.search('title').text
      puts entry.xpath('media:group/media:player').first['url']
      puts
      new_data = YoutubeMovie.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], priority: nil)
      if new_data.save
      else
        p "save error"
      end
    end
  end
end
