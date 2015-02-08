# coding: utf-8

namespace :asumistream do

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
        expanded_urls = []
        event[:target_object][:entities][:urls].each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
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
    end

    ## read timeline
    client.userstream do | status |
      if (status.in_reply_to_user_id != nil) && (!status.text.include?("RT")) && (!status.text.include?("QT")) && (status.user.screen_name != Settings.twitter.user_name) && (status.text.include?("@"+Settings.twitter.user_name))
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
              update("新しく動画が追加されたよ\n" + "【" + title + "】", url)
            else
              already = AlreadySerif.all.sample.word
              update("@" + user_name + " " + already + "\n", url)
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
              update("新しく動画が追加されたよ\n" + "【" + title + "】", url)
            else
              already = AlreadySerif.all.sample.word
              update("@" + user_name + " " + already + "\n", url)
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

        movie_info = "【" + movies.title + "】"
        tweet = ReplySerif.all.sample.word + " \n"
        update("@" + user_name + " " + tweet + movie_info, movies.url)

      elsif ((status.text.include?("RT") || status.text.include?("QT")) && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
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
        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          # search object
          if expand_url.include?("youtube")
            movie_object = YoutubeMovie.where(url: expand_url).first
          elsif expand_url.include?("nicovideo")
            movie_object = NiconicoMovie.where(url: expand_url).first
          end
          # add object
          if movie_object.present?
            movie_object.rt_users.push(user)
            movie_object.save!
          end
        end
      elsif (status.urls.any?{|w| w.expanded_url.include?("/movies/show_")} && (status.text.include?("@"+Settings.twitter.user_name)) && (status.user.screen_name != Settings.twitter.user_name))
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

        expanded_urls = []
        status.urls.each do |url|
          expanded_urls.push(url.expanded_url)
        end
        expanded_urls.each do |expand_url|
          if expand_url.include?("show_youtube")
            s = expand_url.index("show_youtube/")
            id = expand_url[(s+("show_youtube/").length)..200].to_i
            movie_object = YoutubeMovie.find(id)
          elsif expand_url.include?("show_niconico")
            s = expand_url.index("show_niconico/")
            id = expand_url[(s+("show_niconico/").length)..200].to_i
            movie_object = NiconicoMovie.find(id)
          end
          # add object
          if movie_object.present?
            movie_object.rt_users.push(user)
            movie_object.save!
          end
        end
      end
    end
  end


  private
  def setting_tweetstream
    TweetStream.configure do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.oauth_token        = Settings.twitter.oauth_token
      config.oauth_token_secret = Settings.twitter.oauth_token_secret
      config.auth_method        = :oauth
    end
  end
  def setting_twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.access_token        = Settings.twitter.oauth_token
      config.access_token_secret = Settings.twitter.oauth_token_secret
    end
  end
  def confirm_youtube(url)
    if !url.include?("youtube.com/watch?")
      return false
    end
    uri = URI(url)
    uri.scheme = "https"
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
        youtube = YoutubeMovie.where(:url => url).first
        youtube.update_attributes!(:disabled => false)
        youtube.save
        return "youtube"
      else
        ## DBから探し出しdisabled => true
        youtube = YoutubeMovie.where(:url => url).first
        youtube.update_attributes!(:disabled => true)
        youtube.save
        return false
      end
    elsif url.include?("nicovideo.jp/watch")
      if confirm_niconico(url)
        ## 問題なし
        niconico = NiconicoMovie.where(:url => url).first
        niconico.update_attributes!(:disabled => false)
        niconico.save
        return "niconico"
      else
        ## DBから探し出しdisabled => true
        niconico = NiconicoMovie.where(:url => url).first
        niconico.update_attributes!(:disabled => true)
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
