class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  # Mostrar todos los posts
  def index
    @posts = Post.all
  end

  # Mostrar un post individual con comentarios
  def show
    @comments = @post.comments  # Carga todos los comentarios del post
  end

  # Formulario para crear un nuevo post
  def new
    @post = Post.new
  end

  # Crear un nuevo post y asociarlo al usuario actual
  def create
    @post = current_user.posts.build(post_params)  # Asocia el post al usuario autenticado

    if @post.save  # Intenta guardar el post en la base de datos
      redirect_to @post, notice: "Post was successfully created."  # Si tiene éxito, redirige a la vista del post
    else
      render :new  # Si no se guarda, vuelve a mostrar el formulario de nuevo
    end
  end

  # Mostrar el formulario para editar un post
  def edit
    authorize_user  # Verifica que el usuario que intenta editar el post sea el autor
  end

  # Actualizar un post
  def update
    return unless authorize_user  # Detiene la ejecución si el usuario no está autorizado

    if @post.update(post_params)  # Actualiza el post
      redirect_to @post, notice: "Post was successfully updated."  # Redirige a la vista del post actualizado
    else
      render :edit  # Si hay errores, renderiza el formulario de edición
    end
  end

  # Eliminar un post
  def destroy
    return unless authorize_user # Detiene la ejecución si el usuario no está autorizado

    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."  # Redirige a la lista de posts
  end

  private

  # Encontrar un post por ID
  def set_post
    @post = Post.find(params[:id])
  end

  # Permitir solo los parámetros permitidos
  def post_params
    params.require(:post).permit(:title, :content)  # Permite solo los parámetros que necesitamos
  end

  # Autorizar que el usuario actual pueda modificar el post
  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, alert: "Not authorized"
      return false
    end
    true
  end
end
