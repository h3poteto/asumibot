# coding: utf-8

namespace :checkmovie do
  desc "check recent movie"
  task :recent => :environment do
    include Movies
    current = Time.current
    from = 2.weeks.ago
    youtube_rt = YoutubeRtUser.where(created_at: from..current).order("created_at DESC")
    youtube_fav = YoutubeFavUser.where(created_at: from..current).order("created_at DESC")
    niconico_rt = NiconicoRtUser.where(created_at: from..current).order("Created_at DESC")
    niconico_fav = NiconicoFavUser.where(created_at: from..current).order("created_at DESC")
    youtube_movie = []
    niconico_movie = []
    (youtube_rt + youtube_fav).each do |y|
      youtube_movie.push(YoutubeMovie.find(y.youtube_movie_id))
    end
    (niconico_rt + niconico_fav).each do |n|
      niconico_movie.push(NiconicoMovie.find(n.niconico_movie_id))
    end
    (youtube_movie + niconico_movie).each do |m|
      confirm_db(m.url)
    end
  end

  desc "check all youtube"
  task :youtube => :environment do
    include Movies
    YoutubeMovie.all.each do |youtube|
      confirm_db(youtube.url)
    end
  end
end
