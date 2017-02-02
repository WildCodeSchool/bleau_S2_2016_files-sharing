class MediaController < ApplicationController
  before_action :set_medium, only: [:show, :edit, :update, :destroy, :download]

  def download
    if !(authorize @medium)
      flash[:alert] = "You can't download this file"
      render "main/index"
    end
    path = "#{Rails.root}/public#{params[:path]}"
    if File.file? path
      send_file path
    else
      flash[:alert] = "there is a problem with this file, you can't donwload it"
      render "main/index"
    end
  end

  def search_users
    render json: User.search_all_except(current_user, params[:term]).map { |u| u.entity }
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
    Group.my_related_groups(current_user).each do |e|
      @medium.shared_withs.build({entity_id: e.id})
    end
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
    free_params = medium_params.dup
    medium_params[:shared_withs_attributes].values.each_with_index do |attribute, i|
      if attribute[:selected] == "0"
        SharedWith.find(attribute[:id]).destroy
        free_params[:shared_withs_attributes].delete(i.to_s)
      else
        attribute[:selected] = 0
      end
    end
    respond_to do |format|
      if @medium.update(free_params)
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
      params.require(:medium).permit(:user_id, :name, :file, :visible_to_all, entity_ids: [], shared_withs_attributes: [:rights, :entity_id, :selected, :id])
    end
end
