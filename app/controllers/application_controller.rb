class ApplicationController < ActionController::Base
  # Autoriser uniquement les navigateurs modernes
  allow_browser versions: :modern

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path # Redirige vers la dernière page visitée ou la page d'accueil
  end

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || root_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end



class ClipsController < ApplicationController
  before_action :authenticate_user! # S'assure que l'utilisateur est connecté avant d'ajouter un clip

  def new
    @clip = Clip.new
  end

  def create
    @clip = current_user.clips.build(clip_params) # Associe le clip à l'utilisateur connecté

    if @clip.save
      redirect_to @clip, notice: "Clip ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def clip_params
    params.require(:clip).permit(:title, :description, :video) # On ne permet PAS user_id
  end
end
