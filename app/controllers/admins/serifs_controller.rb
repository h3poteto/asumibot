class Admins::SerifsController < AdminsController
  before_filter :authenticate_admin!
  # GET /serifs
  # GET /serifs.json
  def index
    @notice = params[:notice]
    @serifs = PopularSerif.order(:id).all
    @serifs = @serifs + NewSerif.order(:id).all
    @serifs = @serifs + ReplySerif.order(:id).all

  end

  # GET /serifs/1
  # GET /serifs/1.json
  def show
    @serif = Serif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /serifs/new
  # GET /serifs/new.json
  def new
  end

  # GET /serifs/1/edit
  def edit
    @notice = params[:notice]
    @serif = Serif.find(params[:id])
  end

  # POST /serifs
  # POST /serifs.json
  def create
    @serif = nil
    case params[:serif][:type]
    when "ReplySerif"
      @serif = ReplySerif.new(params[:serif])
    when "PopularSerif"
      @serif = PopularSerif.new(params[:serif])
    when "NewSerif"
      @serif = NewSerif.new(params[:serif])
    end

    respond_to do |format|
      if @serif.save
        format.html { redirect_to action: "edit", id: @serif.id, notice: 'Serif was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /serifs/1
  # PUT /serifs/1.json
  def update
    @serif = nil
    case params[:serif][:type]
      when "ReplySerif"
          @serif = ReplySerif.find(params[:id])
      when "PopularSerif"
          @serif = PopularSerif.find(params[:id])
      when "NewSerif"
          @serif = NewSerif.find(params[:id])
      else
          @serif = nil
    end

    respond_to do |format|
      if @serif.update_attributes(params[:serif])
        format.html { redirect_to :action => "edit", notice: 'Serif was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /serifs/1
  # DELETE /serifs/1.json
  def destroy
    @serif = Serif.find(params[:id])
    @serif.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index", notice: "Serif was successfully deleted." }
    end
  end
end
