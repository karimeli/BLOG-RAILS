class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])  # Encuentra el post al que pertenece el comentario
    @comment = @post.comments.create(comment_params)  # Crea el comentario asociado al post
    redirect_to @post  # Redirige al post donde se mostró el comentario
  end

  private

  # Permite solo los parámetros necesarios para el comentario
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
