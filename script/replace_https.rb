YoutubeMovie.all.each do |youtube_movie|
  uri = URI(youtube_movie.url)
  uri.scheme = "https"
  youtube_movie.update_attributes!(url: uri.to_s)
end
