# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = 'http://gdata.youtube.com/feeds/api/videos?vq='
keywords = URI.encode('阿澄佳奈')
@asumi_word = ['阿澄','佳奈','あすみ','アスミ']
@except_word = ['中田あすみ','東方','シルクロード','歌ってみた','明日美','hito20','明日実','ピストン西沢','ふぉんだんみんと','mariavequoinette','http://www.reponet.tv','アカツキ']
@searchwords = ['阿澄佳奈','阿澄','あすみん','アスミス','もこたん']

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do

    options = '&orderby=published&time=today'

    uri = URI(URL + keywords + options )
    doc = Nokogiri::XML(uri.read)
    search_youtube(doc)
  end

  desc "all youtube movie get"
  task :all => :environment do
    @searchwords.each do | words |
      keywords = URI.encode(words)
      i = 0
      while true
        options = '&orderby=relevance&max-result=25&lr=ja&start-index=' + (i*25+1).to_s
        i += 1
        uri = URI(URL + '%22' + keywords + '%22' + options )
        begin
          doc = Nokogiri::XML(uri.read)
        rescue
          break
        end
        if doc.search('entry').blank?
          break
        end
        doc.search('entry').each do |entry|
          next if !asumi_check(entry.search('content').text) && !asumi_check(entry.search('title').text)
          next if !except_check(entry.search('content').text) || !except_check(entry.search('title').text)
          puts entry.search('title').text
          puts entry.xpath('media:group/media:player').first['url']
          new_data = YoutubeMovie.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], priority: nil)
          p new_data.save
          sleep(0.01)
          puts
        end
      end
    end
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

  def search_youtube(doc)
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

  def asumi_check(word)
    @asumi_word.each do |asumi|
      return true if word.include?(asumi)
    end
    return false
  end
  def except_check(word)
    @except_word.each do |except|
      return false if word.include?(except)
    end
    return true
  end

end
