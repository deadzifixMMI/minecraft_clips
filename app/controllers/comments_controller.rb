class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @clip = Clip.find(params[:clip_id])
    @comment = @clip.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to clips_path, notice: 'Commentaire ajouté.'
    else
      redirect_to clips_path, alert: "Erreur lors de l'ajout du commentaire."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
