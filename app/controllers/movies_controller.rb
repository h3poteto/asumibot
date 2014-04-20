require 'open-uri'
class MoviesController < ApplicationController
  layout "user"
  # GET /movies
  # GET /movies.json
  def index

    @search_niconico = NiconicoMovie.search(:title_or_url_or_description_cont => params[:search])
    @search_youtube = YoutubeMovie.search(:title_or_url_or_description_cont => params[:search])
    @niconico = @search_niconico.result.where(disabled: false).order("id DESC")
    @youtube = @search_youtube.result.where(disabled: false).order("id DESC")
    @movies = @niconico + @youtube
    @movies.sort! do |a, b|
       b.created_at <=> a.created_at
    end



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show_youtube
    @youtube = YoutubeMovie.find(params[:id])
    s = @youtube.url.index("?v=")
    e = @youtube.url.index("&")
    @id = @youtube.url[s+3..e-1]
  end
  def show_niconico
    @niconico = NiconicoMovie.find(params[:id])
    s = @niconico.url.index("/watch/")
    @id = @niconico.url[s+7..100]
  end

  def streaming
    @movies= YoutubeMovie.where(disabled: false)
    hashes = []
    @movies.each do |m|
      s = m.url.index("?v=")
      e = m.url.index("&")
      hashes.push({:title => m.title, :id => m.url[s+3..e-1]})
    end
    gon.youtube = hashes
  end

  def streamnico
    @movies = NiconicoMovie.where(disabled: false).sample
    # hashes = []
    # @movies.each do |m|
    #   s = m.url.index("/watch/")
    #   hashes.push({:title => m.title, :nicovideo_url => m.url,:nicovideo_id => m.url[s+7..100], :db_id => m.id})
    # end
    s = @movies.url.index("/watch/")
    @id = @movies.url[s+7..100]
    @url = @movies.url
    @script = open(Settings.site.fqdn + "nico_ext_autoplay.php?URL=http://ext.nicovideo.jp/thumb_watch/#{@id}?w=490&h=307").read
  end
end
