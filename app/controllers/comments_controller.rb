class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])  # Encuentra la publicación
    @comment = @post.comments.find(params[:id])  # Encuentra el comentario
    @comment.destroy  # Elimina el comentario
    redirect_to post_path(@post), notice: "Comment was successfully deleted."  # Redirige al post
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
