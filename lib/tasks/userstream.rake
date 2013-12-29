# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'tweetstream'

namespace :userstream do

  desc "reply userstream"
  task :reply => :environment do
    setting_tweetstream
    setting_twitter
    client = TweetStream::Client.new
    
    ## for fav event
    client.on_event(:favorite) do |event|
      if event[:event] == "favorite"
        # search user
        user_id = event[:source][:id]
        user = User.where(twitter_id: user_id)
        if user.blank?
          new_user = User.new(screen_name: event[:source][:screen_name], twitter_id: user_id.to_i)
          new_user.save
          user = new_user
        else
          user = user.first
        end

        # find url
        text = event[:target_object][:text]
        expand_url = ""
        if text.include?("https:")
          http_url = text.gsub('https:','http:')
          expand_url = UrlExpander::Client.expand(http_url) if http_url.include?('http:')
        else
          expand_url = UrlExpander::Client.expand(text) if text.include?('http:')
        end

        # search object
        if expand_url.include?("youtube")
          movie_object = YoutubeMovie.where(url: expand_url).first
        elsif expand_url.include?("nicovideo")
          movie_object = NiconicoMovie.where(url: expand_url).first
        end
        # add object
        if movie_object.present?
          movie_object.fav_users.push(user)
          movie_object.save!
        end
      end
    end

    ## read timeline
    client.userstream do | status |
      if (status.in_reply_to_user_id != nil) && (!status.text.include?("RT")) && (!status.text.include?("QT")) && (status.user.screen_name != Settings['twitter']['user_name']) && (status.text.include?("@"+Settings['twitter']['user_name']))
        puts status.user.screen_name
        puts status.text
        puts "\n"
        
        # userstreamなのでlastはチェックいらない
        last_men = LastData.where(:category => "mention").first
        men = status
        user_name = men.user.screen_name
        last_men.tweet_id = men.id.to_s
        last_men.save

        # URL expand
        expand_url = ""
        # https
        if men.text.include?("https:")
          http_url = men.text.gsub('https:','http:')
          expand_url = UrlExpander::Client.expand(http_url) if http_url.include?("http:")
        else
          expand_url = UrlExpander::Client.expand(men.text) if men.text.include?("http:")
        end


        # youtube,nicovideoを含む場合はDBに登録する
        if expand_url.include?("www.nicovideo.jp/watch")
          start_pos = expand_url.index("watch/")
          end_pos = expand_url.index("?",start_pos)
          end_pos = 100 if end_pos == nil
          movie_id = expand_url[start_pos+6..end_pos-1]
          uri = URI("http://ext.nicovideo.jp/api/getthumbinfo/" + movie_id)
          begin
            doc = Nokogiri::XML(uri.read)
          rescue
            next
          end
          description = doc.search('description').text
          title = doc.search('title').text
          url = doc.search('watch_url').text
          if title.present? && url.present?
            new_data = NiconicoMovie.create(title: title, url: url, description: description, priority: nil)
            if new_data.save
              update("新しく動画が追加されたよ\n" + "【" + title + "】" + url)
            else
              already = AlreadySerif.all.sample.word
              update("@" + user_name + " " + already + "\n" + url)
            end
          end
          next
        elsif expand_url.include?("youtube.com/watch?")
          start_pos = expand_url.index("watch?v=")
          end_pos = expand_url.index("&",start_pos)
          end_pos = 100 if end_pos == nil
          movie_id = expand_url[start_pos+8..end_pos-1]
          uri = URI("http://gdata.youtube.com/feeds/api/videos/" + movie_id)
          begin
            doc = Nokogiri::XML(uri.read)
          rescue
            next
          end
          content = doc.search('content').text
          title = doc.search('title').text
          url = doc.search('link').first['href'] + "_player"
          if content.present? || title.present? || url.present?
            new_data = YoutubeMovie.create(title: title, url: url, description: content, priority: nil)
            if new_data.save
              update("新しく動画が追加されたよ\n" + "【" + title + "】" + url)
            else
              already = AlreadySerif.all.sample.word
              update("@" + user_name + " " + already + "\n" + url)
            end
          end
          next
        end
        # DBアクセス
        movies = nil
        begin
          random = rand(4)
          if random == 1
            movies = YoutubeMovie.where(:disabled => false).sample
          else
            movies = NiconicoMovie.where(:disabled => false).sample
          end

        end while !confirm_db(movies.url)

        movie_info = "【" + movies.title + "】" + movies.url
        tweet = ReplySerif.all.sample.word + " \n"
        update("@" + user_name + " " + tweet + movie_info)

      elsif ((status.text.include?("RT") || status.text.include?("QT")) && (status.text.include?("@"+Settings['twitter']['user_name'])) && (status.user.screen_name != Settings['twitter']['user_name']))
        ## for RT
        # search user
        user_id = status.user.id.to_i
        user = User.where(twitter_id: user_id)
        if user.blank?
          new_user = User.new(screen_name: status.user.screen_name, twitter_id: user_id)
          new_user.save
          user = new_user
        else
          user = user.first
        end
        
        # find url
        text = status.text
        
        expand_url = ""
        if text.include?("https:")
          http_url = text.gsub('https:','http:')
          expand_url = UrlExpander::Client.expand(http_url) if http_url.include?('http:')
        else
          expand_url = UrlExpander::Client.expand(text) if text.include?('http:')
        end
        # search object
        if expand_url.include?("youtube")
          movie_object = YoutubeMovie.where(url: expand_url).first
        elsif expand_url.include?("nicovideo")
          movie_object = NiconicoMovie.where(url: expand_url).first
        end
        # add object
        debugger
        p movie_object
        if movie_object.present?
          movie_object.rt_users.push(user)
          movie_object.save!
        end
        debugger
        p movie_object
      end
    end
  end


  private
  def setting_tweetstream
    TweetStream.configure do |config|
      config.consumer_key       = Settings['twitter']['consumer_key']
      config.consumer_secret    = Settings['twitter']['consumer_secret']
      config.oauth_token        = Settings['twitter']['oauth_token']
      config.oauth_token_secret = Settings['twitter']['oauth_token_secret']
      config.auth_method        = :oauth
    end
  end
  def setting_twitter
    Twitter.configure do |config|
      config.consumer_key       = Settings['twitter']['consumer_key']
      config.consumer_secret    = Settings['twitter']['consumer_secret']
      config.oauth_token        = Settings['twitter']['oauth_token']
      config.oauth_token_secret = Settings['twitter']['oauth_token_secret']
    end
  end
  def confirm_youtube(url)
    if !url.include?("youtube.com/watch?")
      return false
    end
    uri = URI(url)
    begin
      doc = Nokogiri::XML(uri.read)
    rescue
      return false
    end
    
    if doc.search('title').text == "YouTube"
      return false
    else
      return true
    end
  end
  def confirm_niconico(url)
    if !url.include?("nicovideo.jp/watch")
      return false
    end
    start_pos = url.index("watch/")
    end_pos = url.index("?", start_pos)
    end_pos = 100 if end_pos == nil
    movie_id = url[start_pos+6..end_pos-1]

    uri = URI("http://ext.nicovideo.jp/api/getthumbinfo/" + movie_id)
    begin
      doc = Nokogiri::XML(uri.read)
    rescue
      return false
    end
    if doc.search('code').text == "DELETED" || doc.search('code').text == "NOT_FOUND"
      return false
    else
      return true
    end
  end

  def confirm_db(url)
    if url.include?("youtube.com/watch?")
      if confirm_youtube(url)
        ## 問題なし
        return "youtube"
      else
        ## DBから探し出しdisabled => false
        youtube = YoutubeMovie.where(:url => url).first
        youtube.update_attributes!(:disabled => true)
        youtube.save
        return false
      end
    elsif url.include?("nicovideo.jp/watch")
      if confirm_niconico(url)
        ## 問題なし
        return "niconico"
      else
        ## DBから探し出しdisabled => false
        niconico = NiconicoMovie.where(:url => url).first
        niconico.update_attributes!(:disabled => url).first
        niconico.save
        return false
      end
    else
      ## 予定外のurl
      ## DBからの抜き出しなら例外
      return false
    end
  end
end
