class RecommendsController < ApplicationController
  layout "user"
  def index
    @all_fav_youtube = YoutubeFavUser.ranking(1.month.ago).take(3)
    @all_fav_niconico = NiconicoFavUser.ranking(1.month.ago).take(3)
    @all_rt_youtube = YoutubeRtUser.ranking(1.month.ago).take(3)
    @all_rt_niconico = NiconicoRtUser.ranking(1.month.ago).take(3)
  end

end
