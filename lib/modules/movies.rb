require 'open-uri'
module Movies
  def confirm_db(url)
    if url.include?("youtube.com/watch?")
      if confirm_youtube(url)
        ## 問題なし
        youtube = YoutubeMovie.where(:url => url).first
        youtube.update_attributes!(:disabled => false)
        return "youtube"
      else
        ## DBから探し出しdisabled => true
        youtube = YoutubeMovie.where(:url => url).first
        youtube.update_attributes!(:disabled => true)
        return false
      end
    elsif url.include?("nicovideo.jp/watch")
      if confirm_niconico(url)
        ## 問題なし
        niconico = NiconicoMovie.where(:url => url).first
        niconico.update_attributes!(:disabled => false)
        return "niconico"
      else
        ## DBから探し出しdisabled => true
        niconico = NiconicoMovie.where(:url => url).first
        niconico.update_attributes!(:disabled => true)
        return false
      end
    else
      ## 予定外のurl
      ## DBからの抜き出しなら例外
      return false
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

  def find_movie(expand_url)
    if expand_url.to_s.include?("youtube")
      movie_object = YoutubeMovie.where(url: expand_url.to_s).first
    elsif expand_url.to_s.include?("nicovideo")
      movie_object = NiconicoMovie.where(url: expand_url.to_s).first
    end
    movie_object
  end

  def find_random
    begin
      random = rand(4)
      if random == 1
        movie = YoutubeMovie.available.sample
      else
        movie = NiconicoMovie.available.sample
      end
    end while !confirm_db(movie.url)
    movie
  end

  def include_asumich?(urls)
    urls.any? {|w| w.expanded_url.to_s.include?("/movies/show_") }
  end

  def find_movie_for_asumich(expand_url)
    if expand_url.to_s.include?("show_youtube")
      s = expand_url.to_s.index("show_youtube/")
      id = expand_url.to_s[(s+("show_youtube/").length)..200].to_i
      movie_object = YoutubeMovie.find(id)
    elsif expand_url.to_s.include?("show_niconico")
      s = expand_url.to_s.index("show_niconico/")
      id = expand_url.to_s[(s+("show_niconico/").length)..200].to_i
      movie_object = NiconicoMovie.find(id)
    end
    movie_object
  end
end
