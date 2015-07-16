# coding: utf-8

require 'nokogiri'
require 'open-uri'

namespace :youtube do
  desc "new youtube movie get"
  task :new => :environment do
    client = YoutubeClient.new

    opts = {
      maxResults: 50,
      order: 'date',
      type: 'video',
      publishedAfter: Time.current.yesterday.to_datetime.rfc3339
    }
    client.search(opts)
    client.update_today
  end

  desc "popular youtube movie get"
  task :popular => :environment do
    client = YoutubeClient.new
    opts = {
      maxResults: 50,
      order: 'rating',
      type: 'video'
    }
    client.search(opts)
    client.update_popular
  end

  desc "clear db"
  task :clear => :environment do
    YoutubePopular.delete_all(["created_at < ?","Today"])
    TodayYoutube.delete_all(["created_at < ?", "Today"])
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
=end

end
