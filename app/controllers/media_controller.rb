class MediaController < ApplicationController
  before_action :set_medium, only: [:show, :edit, :update, :destroy]

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
    @groups = helpers.groups

    # passage des id des checkboxs du formulaire pour le js
    groups_id_tab = []
    @groups.each do |g|
      groups_id_tab << g.entity.id
    end
    @groups_id_string = '#' + groups_id_tab.join(', #')
    # fin de passage de variable au js

  end

  # GET /media/1/edit
  def edit
  end

  # POST /media
  # POST /media.json
  def create
    # set des paramètres pour le média
    @medium = Medium.new(medium_params)
    @medium.user = current_user

    # set groupes ayant accès au fichier
    groups = helpers.groups
    groups.each do |g|
      if params.has_key?(g.entity.id.to_s)
        @medium.entities << Entity.find(g.entity.id)
      end
    end

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
      params.require(:medium).permit(:name, :file, :visible_to_all)
    end
end
