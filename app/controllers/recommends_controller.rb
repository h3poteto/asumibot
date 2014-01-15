class RecommendsController < ApplicationController
  layout "user"
  def index
    @new_fav_youtube = YoutubeFavUser.new().take(3)
    @new_fav_niconico = NiconicoFavUser.new().take(3)
    @new_rt_youtube = YoutubeRtUser.new().take(3)
    @new_rt_niconico = NiconicoRtUser.new().take(3)

    @first_fav_youtube = YoutubeFavUser.order("created_at DESC").first
    @first_fav_niconico = NiconicoFavUser.order("created_at DESC").first
    @first_rt_youtube = YoutubeRtUser.order("created_at DESC").first
    @first_rt_niconico = NiconicoRtUser.order("created_at DESC").first
    
    if @first_fav_youtube.created_at.to_s(:db) > @first_fav_niconico.created_at.to_s(:db)
      @top_new = @first_fav_youtube
    else
      @top_new = @first_fav_niconico
    end
    
    if @first_rt_youtube.created_at.to_s(:db) > @top_new.created_at.to_s(:db)
      @top_new = @first_rt_youtube
    end

    if @first_rt_niconico.created_at.to_s(:db) > @top_new.created_at.to_s(:db)
      @top_new = @first_rt_niconico
    end
    begin
      if @top_new.niconico_movie_id.present?
        @top_movie = NiconicoMovie.find(@top_new.niconico_movie_id)
        @movie_type = "nicovideo"
      end
    rescue
      if @top_new.youtube_movie_id.present?
        @top_movie = YoutubeMovie.find(@top_new.youtube_movie_id)
        @movie_type = "youtube"
      end
    end
  end

  @new_youtube = TodayYoutube.all.sample(4)
  @new_niconico = TodayNiconico.all.sample(4)

end
