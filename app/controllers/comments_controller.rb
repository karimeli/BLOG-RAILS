# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  # Acción para manejar la carga de imágenes
  def upload_image
    # Crear un nuevo comentario para manejar la carga de la imagen
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: { uploaded: true, url: @comment.image.url }  # Enviar la URL de la imagen subida
    else
      render json: { uploaded: false, error: "Error al cargar la imagen" }
    end
  end

  # Acción de creación de comentario
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render "posts/show"
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])  # Encuentra el post
  end

  def set_comment
    @comment = Comment.find(params[:id])  # Encuentra el comentario
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter, :image)  # Permite el atributo de imagen
  end
end
