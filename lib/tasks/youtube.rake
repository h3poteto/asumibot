# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = 'http://gdata.youtube.com/feeds/api/videos?vq='
keywords = URI.encode('阿澄佳奈')
@asumi_word = ['阿澄','アスミス','阿澄佳奈']
@except_word = ['中田あすみ','東方','シルクロード','歌ってみた','明日美','hito20','明日実','ピストン西沢','ふぉんだんみんと','mariavequoinette','http://www.reponet.tv','アカツキ','弾いてみた','やってみた','湾岸','太鼓さん次郎','明治神宮']
@searchwords = ['阿澄佳奈','阿澄さん','アスミス','もこたん']

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do

    options = '&orderby=published&time=today'
    @searchwords.each do | words |
      keywords = URI.encode(words)
      uri = URI(URL + '%22' +  keywords + '%22' + options )
      doc = Nokogiri::XML(uri.read)
      add_youtube(doc,true)
    end
  end

  desc "all youtube movie get"
  task :all => :environment do
    @searchwords.each do | words |
      keywords = URI.encode(words)
      i = 0
      while true
        options = '&orderby=relevance&time=all_time&max-result=25&start-index=' + (i*25+1).to_s
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
        add_youtube(doc,false)
      end
    end
  end
  
  desc "popular youtube movie get"
  task :popular => :environment do
    options = '&orderby=viewCount&time=all_time'

    @searchwords.each do | words |
      keywords = URI.encode(words)
      uri = URI(URL + keywords + options )
      doc = Nokogiri::XML(uri.read)
      i = 1
      doc.search('entry').each do |entry|
        next if !asumi_check(entry.search('content').text) && !asumi_check(entry.search('title').text)
        next if !except_check(entry.search('content').text) || !except_check(entry.search('title').text)
        #puts entry.search('title').text
        #puts entry.xpath('media:group/media:player').first['url']
        new_data = YoutubePopular.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], description: entry.search('content').text, priority: i)
        if new_data.save
          i+=1
          sleep(0.01)
          #p true
        else
          #p false
        end
        #puts
      end
    end
  end

  desc "clear db"
  task :clear => :environment do
    YoutubePopular.delete_all(["created_at < ?","Today"])
    TodayYoutube.delete_all(["created_at < ?", "Today"])
  end



#############################
# 関数定義
#############################

  def add_youtube(doc, new_flag)
    doc.search('entry').each do |entry|
      next if !asumi_check(entry.search('content').text) && !asumi_check(entry.search('title').text)
      next if !except_check(entry.search('content').text) || !except_check(entry.search('title').text)
      #puts entry.search('title').text
      #puts entry.xpath('media:group/media:player').first['url']
      if new_flag
        today_data = TodayYoutube.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], description: entry.search('content').text, priority: nil)
        today_data.save
      end
      new_data = YoutubeMovie.create(title: entry.search('title').text, url: entry.xpath('media:group/media:player').first['url'], description: entry.search('content').text, priority: nil)
      new_data.save
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
