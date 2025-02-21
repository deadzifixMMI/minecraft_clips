class ClipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_clip, only: %i[edit update destroy]

  def index
    @clips = Clip.all
  end

  def new
    @clip = current_user.clips.build
  end

  def create
    @clip = current_user.clips.build(clip_params)

    if @clip.save
      redirect_to clips_path, notice: 'Clip ajouté avec succès.'
    else
      render :new
    end
  end

  def edit
    # La méthode set_clip garantit qu'on ne modifie que le clip de l'utilisateur
  end

  def update
    if @clip.update(clip_params)
      redirect_to clips_path, notice: 'Clip mis à jour avec succès.'
    else
      render :edit
    end
  end

  def show
    @clip = Clip.find_by(id: params[:id])

    # Si le clip n'existe pas, on redirige ou affiche une erreur
    return if @clip

    redirect_to clips_path, alert: "Le clip demandé n'existe pas."
  end

  def destroy
    @clip = current_user.clips.find(params[:id]) # Vérifie que l'utilisateur supprime uniquement ses clips
    @clip.destroy
    redirect_to clips_path, notice: 'Clip supprimé avec succès.'
  end

  private

  def set_clip
    @clip = Clip.find(params[:id])

    # Empêche l'accès au clip si ce n'est pas celui de l'utilisateur actuel
    return if @clip.user == current_user

    redirect_to clips_path, alert: 'Vous ne pouvez pas modifier ou supprimer ce clip.'
  end

  def clip_params
    params.require(:clip).permit(:title, :video)
  end
end
