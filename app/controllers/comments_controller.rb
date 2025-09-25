# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :upload_image ]
  before_action :authenticate_user!
  before_action :set_post, except: [ :upload_image ]
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  # --- OTRAS ACCIONES (edit, update, destroy) ---
  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully destroyed."
  end
  # ---------------------------------------------

  # === ACCIÓN CORREGIDA PARA SUBIR IMÁGENES ===
  def upload_image
    # Usamos el modelo Ckeditor::Picture directamente para manejar la imagen
    @picture = Ckeditor::Picture.new
    @picture.data = params[:upload] # Asignamos el archivo subido

    # Guardamos la imagen
    if @picture.save
      # Si se guarda, respondemos con el JSON que CKEditor espera
      render json: {
        uploaded: true,
        url: @picture.url
      }
    else
      # Si falla, respondemos con un error claro
      render json: {
        uploaded: false,
        error: { message: "Upload failed" }
      }, status: :unprocessable_entity
    end
  end

  # Acción para crear un comentario (esta no cambia)
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
    @post = Post.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter, :image)
  end
end
