class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]  # Incluimos :edit y :update aquí

  def create
    @comment = current_user.comments.build(comment_params)  # Asocia el comentario al usuario
    @comment.post = @post  # Asocia el comentario al post

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render "posts/show"
    end
  end

  def edit
    # La acción edit solo muestra el formulario para editar el comentario
  end

  def update
    if @comment.update(comment_params)  # Actualiza el comentario con los nuevos datos
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit  # Si hay errores, vuelve al formulario de edición
    end
  end

  def destroy
    @comment.destroy  # Elimina el comentario
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])  # Encuentra el post asociado
  end

  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to @post, alert: "You are not authorized to perform this action."
    end
  end
  def comment_params
    params.require(:comment).permit(:content, :body, :commenter)
  end
end
