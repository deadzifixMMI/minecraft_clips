class ClipsController < ApplicationController
  before_action :authenticate_user! # Oblige la connexion pour accéder aux clips
  before_action :set_clip, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy] # Vérifie si l'utilisateur est le propriétaire du clip

  # GET /clips or /clips.json
  def index
    @clips = Clip.all
  end

  # GET /clips/1 or /clips/1.json
  def show
  end

  # GET /clips/new
  def new
    @clip = current_user.clips.build # Associe directement le clip au user connecté
  end

  # GET /clips/1/edit
  def edit
  end

  # POST /clips or /clips.json
  def create
    @clip = current_user.clips.build(clip_params) # Associe le clip à l'utilisateur connecté

    respond_to do |format|
      if @clip.save
        format.html { redirect_to @clip, notice: "Clip was successfully created." }
        format.json { render :show, status: :created, location: @clip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clips/1 or /clips/1.json
  def update
    respond_to do |format|
      if @clip.update(clip_params)
        format.html { redirect_to @clip, notice: "Clip was successfully updated." }
        format.json { render :show, status: :ok, location: @clip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clips/1 or /clips/1.json
  def destroy
    @clip.destroy!

    respond_to do |format|
      format.html { redirect_to clips_path, status: :see_other, notice: "Clip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Récupère le clip en fonction de l'ID
  def set_clip
    @clip = Clip.find(params[:id]) # Correction de `params.expect(:id)` -> `params[:id]`
  end

  # Vérifie si l'utilisateur est bien le propriétaire du clip avant de modifier/supprimer
  def authorize_user!
    unless @clip.user == current_user
      redirect_to clips_path, alert: "Vous ne pouvez pas modifier ou supprimer ce clip."
    end
  end

  # Permet uniquement les paramètres de formulaire sécurisés
  def clip_params
    params.require(:clip).permit(:title, :description, :video) # Correction `params.expect` -> `params.require`
  end
end
