class RecommendsController < ApplicationController
  layout "user"
  def index
    @new_fav_youtube = YoutubeFavUser.recent(2.week.ago).take(3)
    @new_fav_niconico = NiconicoFavUser.recent(2.week.ago).take(3)
    @new_rt_youtube = YoutubeRtUser.recent(2.week.ago).take(3)
    @new_rt_niconico = NiconicoRtUser.recent(2.week.ago).take(3)

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

    if @top_new.kind_of?(NiconicoFavUser) || @top_new.kind_of?(NiconicoRtUser)
      @top_movie = NiconicoMovie.find(@top_new.niconico_movie_id)
      @movie_type = "nicovideo"
    elsif @top_new.kind_of?(YoutubeFavUser) || @top_new.kind_of?(YoutubeRtUser)
      @top_movie = YoutubeMovie.find(@top_new.youtube_movie_id)
      @movie_type = "youtube"
    end

    if @top_new.kind_of?(NiconicoFavUser)
      @type = "Fav"
      @number = NiconicoFavUser.where(niconico_movie_id: @top_new.niconico_movie_id).length
    elsif @top_new.kind_of?(NiconicoRtUser)
      @type = "RT"
      @number = NiconicoRtUser.where(niconico_movie_id: @top_new.niconico_movie_id).length
    elsif @top_new.kind_of?(YoutubeRtUser)
      @type = "RT"
      @number = YoutubeRtUser.where(youtube_movie_id: @top_new.youtube_movie_id).length
    elsif @top_new.kind_of?(YoutubeFavUser)
      @type = "Fav"
      @number = YoutubeFavUser.where(youtube_movie_id: @top_new.youtube_movie_id).length
    end
  end

  @new_youtube = TodayYoutube.all.sample(4)
  @new_niconico = TodayNiconico.all.sample(4)

end
