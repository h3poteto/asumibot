module ApplicationHelper
  def movie_show_url(movie)
    if movie.kind_of?(YoutubeMovie) || movie.kind_of?(TodayYoutube)
      return youtube_path(movie)
    elsif movie.kind_of?(NiconicoMovie) || movie.kind_of?(TodayNiconico)
      return niconico_path(movie)
    end
  end

  def determin_url(url)
    if url.index("nicovideo.jp")
      return "niconico"
    elsif url.index("youtube.com")
      return "youtube"
    end
  end

  def youtube_image_url(url)
    id_s = url.index('v=')
    id_e = url.index('&')
    "http://i.ytimg.com/vi/#{url[id_s+2..id_e-1]}/default.jpg" rescue nil
  end

  def niconico_image_url(url)
    id_s = url.index('watch/')
    id = url[id_s+8..100] rescue 1.to_s
    rand = id.to_i % 4 + 1
    "http://tn-skr#{rand.to_s}.smilevideo.jp/smile?i=#{id}"
  end

  def movie_image_url(movie)
    case determin_url(movie["url"])
    when "niconico"
      return image_tag(niconico_image_url(movie["url"]))
    when "youtube"
      return image_tag(youtube_image_url(movie["url"]))
    end
  end

  def movie_show_url(movie)
    case determin_url(movie["url"])
    when "niconico"
      return link_to movie["title"], niconico_path(movie["id"])
    when "youtube"
      return link_to movie["title"], youtube_path(movie["id"])
    end
  end
end
