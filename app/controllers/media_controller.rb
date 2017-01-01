class MediaController < ApplicationController
  before_action :set_medium, only: [:show, :edit, :update, :destroy]

  def search_users
    @users = []
    User.search_all_except(current_user, params[:term]).each do |u|
      @users << u.entity
    end
    render json: @users
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
    helpers.all_groups_entities.each do |e|
      @medium.shared_withs.build({entity_id: e.id})
    end
    @shared_with_groups = @medium.shared_withs
    @users = User.all

    respond_to do |format|
      format.html
      format.json { @users = User.all }
    end
  end

  # POST /media
  # POST /media.json
  def create
    @medium = Medium.new(medium_params)

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

  # GET /media/1/edit
  def edit
  end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to root_path, notice: 'Medium was successfully updated.' }
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
      format.html { redirect_to root_path, notice: 'Medium was successfully destroyed.' }
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
      params.require(:medium).permit(:user_id, :name, :file, :visible_to_all, entity_ids: [], shared_withs_attributes: [:rights, :entity_id, :selected])
    end
end
