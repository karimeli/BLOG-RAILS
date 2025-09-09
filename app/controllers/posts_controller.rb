class PostsController < ApplicationController
  # Autenticación básica
  http_basic_authenticate_with name: "dhh", password: "secret", except: [ :index, :show ]

  # Acción para listar las publicaciones
  def index
    @posts = Post.all
  end

  # Acción para mostrar una publicación específica
  def show
    @post = Post.find(params[:id])
  end

  # Acción para crear una nueva publicación
  def new
    @post = Post.new
  end

  # Acción para crear una publicación en la base de datos
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  # Acción para editar una publicación
  def edit
    @post = Post.find(params[:id])
  end

  # Acción para actualizar una publicación
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  # Acción para eliminar una publicación
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  # Strong parameters: permite solo los parámetros permitidos
  def post_params
    params.require(:post).permit(:name, :title, :content)
  end
end
