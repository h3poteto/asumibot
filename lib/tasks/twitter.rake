# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'twitter'
require 'date'
require 'url_expander'
require 'open-uri'

namespace :twitter do
  desc "normal tweet"
  task :normal => :environment do
    setting_twitter
    movies_array = []
    movies_array.push(NiconicoPopular.where(:used => false).sample)
    movies_array.push(YoutubePopular.where(:used => false).sample)
    movies = movies_array.sample

    # つぶやき
    movie_info = "【" + movies.title + "】" + movies.url
    popular_tweet = PopularSerif.all.sample.word + " \n"
    if update( popular_tweet + movie_info)
      movies.used = true
      movies.save
    end
  end
  
  desc "new asumi movie"
  task :new => :environment do
    setting_twitter
    movies = TodayYoutube.where(:used => false).sample
    if movies == nil
      movies = TodayNiconico.where(:used => false).sample
    end
    
    next if !confirm_db(movies.url)
    # つぶやき
    movie_info = "【" + movies.title + "】" + movies.url
    new_tweet = NewSerif.all.sample.word + "\n" + "（新着）"
    if update( new_tweet + movie_info )
      movies.used = true
      movies.save
    end
  end

  desc "reply tweet"
  task :reply => :environment do
    setting_twitter
    mention = Twitter.mentions
    last_men = LastData.where(:category => "mention").first
    mention.each do |men|
      break if men.id.to_s == last_men.tweet_id.to_s
      user_name = men.user.screen_name
      next if user_name == Settings['twitter']['user_name']
      next if men.text.include?("RT") || men.text.include?("QT")
      # URL expand
      expand_url = ""
      expand_url = UrlExpander::Client.expand(men.text) if men.text.include?("http:")

      # youtube,nicovideoを含む場合はDBに登録する
      if expand_url.include?("www.nicovideo.jp/watch")
        start_pos = expand_url.index("watch/")
        end_pos = expand_url.index("?",start_pos)
        end_pos = 100 if end_pos == nil
        movie_id = expand_url[start_pos+6..end_pos-1]
        uri = URI("http://ext.nicovideo.jp/api/getthumbinfo/" + movie_id)
        doc = Nokogiri::XML(uri.read)
        description = doc.search('description').text
        title = doc.search('title').text
        url = doc.search('watch_url').text
        if title.present? && url.present?
          new_data = NiconicoMovie.create(title: title, url: url, description: description, priority: nil)
          if new_data.save
            update("新しく動画が追加されたよ\n" + "【" + title + "】" + url)
          else
            update("@" + user_name + " " + "ごめん、もう登録されてた")
          end
        end
        next
      elsif expand_url.include?("youtube.com/watch?")
        start_pos = expand_url.index("watch?v=")
        end_pos = expand_url.index("&",start_pos)
        end_pos = 100 if end_pos == nil
        movie_id = expand_url[start_pos+8..end_pos-1]
        uri = URI("http://gdata.youtube.com/feeds/api/videos/" + movie_id)
        doc = Nokogiri::XML(uri.read)
        content = doc.search('content').text
        title = doc.search('title').text
        url = doc.search('link').first['href']
        if content.present? && title.present? && url.present?
          new_data = YoutubeMovie.create(title: title, url: url, description: content, priority: nil)
          if new_data.save
            update("新しく動画が追加されたよ\n" + "【" + title + "】" + url)
          else
            update("@" + user_name + " " + "ごめん、もう登録されてるんだ")
          end
        end
        next
      end
      # DBアクセス
      movies = nil
      random = rand(2)
      if random == 0
        movies = NiconicoMovie.where(:disabled => false).sample
      else
        movies = YoutubeMovie.where(:disabled => false).sample
        user_id = men.user.id
        db_user = User.where(:twitter_id => user_id.to_i ).first
        if db_user.blank?
          db_user = User.new
          db_user.youtube_movies.push(movies)
          db_user.twitter_id = user_id.to_i
          db_user.screen_name = user_name
          db_user.save
        else
          movies.users.push(db_user)
          movies.save
        end
      end

      next if !confirm_db(movies.url)
      movie_info = "【" + movies.title + "】" + movies.url
      tweet = ReplySerif.all.sample.word + " \n"
      update("@" + user_name + " " + tweet + movie_info)
    end
    last_men.tweet_id = mention[0].id.to_s
    last_men.save
  end

  desc "follower"
  task :follower => :environment do
    setting_twitter
    follower = Twitter.follower_ids().ids
    friend = Twitter.friend_ids().ids
    fan = follower - friend
    fan.each do |f|
      Twitter.follow(f)
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
  def update(tweet)
    begin
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      Twitter.update(tweet.chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : " + e.message + ">>"
      return false
    end
    return true
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
