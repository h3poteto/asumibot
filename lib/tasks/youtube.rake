# coding: utf-8

require 'nokogiri'
require 'open-uri'

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do
    client = YoutubeClient.new

    opts = {
      max_results: 50,
      order: 'date',
      type: 'video',
      published_after: Time.current.yesterday.to_datetime.rfc3339
    }
    client.search(opts)
  end

  desc "popular youtube movie get"
  task :popular => :environment do
    options = '&orderby=rating&time=all_time'

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
      add_youtube(doc, false)
    end
  end

=begin
これ初回のみしか使わないのでいらない
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
  desc "clear db"
  task :clear => :environment do
    YoutubePopular.delete_all(["created_at < ?","Today"])
    TodayYoutube.delete_all(["created_at < ?", "Today"])
  end
=end

end
