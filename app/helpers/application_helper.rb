module ApplicationHelper
  def movie_show_url(movie)
    if movie.kind_of?(YoutubeMovie) || movie.kind_of?(TodayYoutube)
      return youtube_path(movie)
    elsif movie.kind_of?(NiconicoMovie) || movie.kind_of?(TodayNiconico)
      return niconico_path(movie)
    end
  end
end
