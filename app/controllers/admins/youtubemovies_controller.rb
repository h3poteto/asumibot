class Admins::YoutubemoviesController < AdminsController
  before_filter :authenticate_admin!
  # GET /youtubemovies
  # GET /youtubemovies.json
  def index
    @search = YoutubeMovie.search(params[:q])
    @youtubemovies = @search.result.order("id DESC").page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @youtubemovies }
    end
  end

  # GET /youtubemovies/1/edit
  def edit
    @notice = params[:notice]
    @youtubemovie = YoutubeMovie.find(params[:id])
  end

  # PUT /youtubemovies/1
  # PUT /youtubemovies/1.json
  def update
    @youtubemovie = YoutubeMovie.find(params[:id])

    respond_to do |format|
      if @youtubemovie.update_attributes(permitted_params)
        format.html { redirect_to action:"edit", notice: 'Youtubemovie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @youtubemovie.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def permitted_params
    params.require(:youtube_movie).permit(:priority, :title, :url, :description, :disabled)
  end

end
