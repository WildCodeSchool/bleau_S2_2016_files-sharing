class MediaController < ApplicationController
  before_action :set_medium, only: [:show, :edit, :update, :destroy]

  def all_groups
    return helpers.owned_groups + current_user.groups
  end

  # passage des id des checkboxs du formulaire pour le js
  def to_js(arr)
    tab = []
    arr.each do |a|
      tab << a.entity.id
    end
    @str = '#' + tab.join(', #')
  end

  # GET /media
  # GET /media.json
  def index
    @media = Medium.all
  end

  # GET /media/1
  # GET /media/1.json
  def show
  end

  # GET /media/new
  def new
    @medium = Medium.new
    @in_groups = current_user.groups
    @groups_entities = []
    @in_groups.each do |g|
      @groups_entities << g.entity
    end

    @owned_groups = helpers.owned_groups
    @groups_id_string = to_js(@in_groups)
  end

  # GET /media/1/edit
  def edit
        @in_groups = current_user.groups
    @groups_entities = []
    @in_groups.each do |g|
      @groups_entities << g.entity
    end

    @owned_groups = helpers.owned_groups
    @groups_id_string = to_js(@in_groups)
  end

  # POST /media
  # POST /media.json
  def create
    # set des paramètres pour le média
    @medium = Medium.new(medium_params)
    @medium.user = current_user

    respond_to do |format|
      if @medium.save
        format.html { redirect_to root_path, notice: 'Medium was successfully created.' }
        format.json { render :show, status: :created, location: @medium }
      else
        format.html { render :new }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  def update
    
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { render :show, status: :ok, location: @medium }
      else
        format.html { render :edit }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium.destroy
    respond_to do |format|
      format.html { redirect_to media_url, notice: 'Medium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medium_params
      params.require(:medium).permit(:name, :file, :visible_to_all, entity_ids: [])
    end
end
