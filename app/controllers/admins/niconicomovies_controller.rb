class Admins::NiconicomoviesController < AdminsController
  before_filter :authenticate_admin!
  # GET /niconicomovies
  # GET /niconicomovies.json
  def index
    @search = NiconicoMovie.search(params[:q])
    @niconicomovies = @search.result.order("id DESC").page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @niconicomovies }
    end
  end

  # GET /niconicomovies/1/edit
  def edit
    @notice = params[:notice]
    @niconicomovie = NiconicoMovie.find(params[:id])
  end

  # PUT /niconicomovies/1
  # PUT /niconicomovies/1.json
  def update
    @niconicomovie = NiconicoMovie.find(params[:id])

    respond_to do |format|
      if @niconicomovie.update_attributes(permitted_params)
        format.html { redirect_to action:"edit", notice: 'Niconicomovie was successfully updated.', status: 200 }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @niconicomovie.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def permitted_params
    params.require(:niconico_movie).permit(:priority, :description, :disabled, :title, :url)
  end
end
