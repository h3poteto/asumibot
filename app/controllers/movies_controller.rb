require 'open-uri'
class MoviesController < ApplicationController
  layout "user"

  before_action :redirect_top, only: [:streaming, :streamnico]

  # GET /movies
  # GET /movies.json
  def index
    respond_to do |format|
      format.html do
        search_niconico = NiconicoMovie.search(:title_or_url_or_description_cont => params[:search])
        search_youtube = YoutubeMovie.search(:title_or_url_or_description_cont => params[:search])
        niconico_sql = search_niconico.result.available.to_sql
        youtube_sql = search_youtube.result.available.to_sql
        union_sql = "#{niconico_sql} union all #{youtube_sql} order by created_at DESC;"
        collection = ActiveRecord::Base.connection.select_all(union_sql)
        @movies = Kaminari.paginate_array(collection.to_a).page(params[:page]).per(20)
      end
      format.json do
        niconico = NiconicoMovie.available.sample
        youtube = YoutubeMovie.available.sample
        @movie = [niconico, youtube].sample
      end
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show_youtube
    @youtube = YoutubeMovie.find(params[:id])
    s = @youtube.url.index("?v=")
    e = @youtube.url.index("&")
    @id = @youtube.url[s+3..e-1] rescue 1
  end
  def show_niconico
    @niconico = NiconicoMovie.find(params[:id])
    s = @niconico.url.index("/watch/")
    @id = @niconico.url[s+7..100] rescue 1
  end

  def streaming
    @movies= YoutubeMovie.where(disabled: false)
    hashes = []
    @movies.each do |m|
      s = m.url.index("?v=")
      e = m.url.index("&")
      hashes.push({:title => m.title, :id => m.url[s+3..e-1]}) rescue nil
    end
    gon.youtube = hashes
  end

  def streamnico
    @movies = NiconicoMovie.where(disabled: false).sample
    s = @movies.url.index("/watch/")
    @id = @movies.url[s+7..100]
    @url = @movies.url
  end

  private
  def redirect_top
    if request.smart_phone? || request.mobile?
      redirect_to root_path
    end
  end
end
