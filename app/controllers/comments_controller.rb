# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :upload_image ]
  before_action :authenticate_user!
  before_action :set_post, except: [ :upload_image ]
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  # Acción para mostrar el formulario de edición de comentario
  def edit
    # La acción edit no necesita hacer nada, solo mostrar el formulario
  end

  # Acción para actualizar el comentario
  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  # Acción para eliminar el comentario
  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  # Acción para manejar la carga de imágenes
  def upload_image
    @comment = Comment.new
    @comment.image = params[:upload]

    if @comment.save
      render json: { uploaded: true, url: @comment.image.url }
    else
      render json: { uploaded: false, error: "Error al cargar la imagen" }
    end
  end

  # Acción para crear un comentario
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      @comments = @post.comments
      render "posts/show"
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter, :image)
  end
end
