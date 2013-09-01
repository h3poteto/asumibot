# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'nokogiri'
require 'open-uri'

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do
    URL = 'http://gdata.youtube.com/feeds/api/videos?vq='
    keywords = URI.encode('阿澄佳奈')
    options = '&orderby=published&time=today'

    uri = URI(URL + keywords + options )
    doc = Nokogiri::XML(uri.read)
    doc.search('entry').each do |entry|
      puts entry.search('title').text
      puts entry.xpath('media:group/media:player').first['url']
      puts

      new_data = YoutubeMovie.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], priority: 1)
      new_data.save
    end

  end
end
