class YoutubesController < ApplicationController

  # GET /youtubes.json
  def index
    @youtube = YoutubeMovie.available.sample
  end

  def today
    @youtube = TodayYoutube.all.sample
  end
end
