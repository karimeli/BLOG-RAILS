class PostsController < ApplicationController
  # 1. Listar todos los posts
  def index
    @posts = Post.all
  end

  # 2. Mostrar un post
  def show
    @post = Post.find(params[:id])
  end

  # 3. Nuevo post
  def new
    @post = Post.new
  end

  # 4. Crear post
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  # 5. Editar post
  def edit
    @post = Post.find(params[:id])
  end

  # 6. Actualizar post
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  # 7. Eliminar post
def destroy
  @post = Post.find(params[:id])  # Encuentra el post a eliminar
  @post.destroy  # Elimina el post de la base de datos
  redirect_to posts_path, notice: "Post was successfully deleted."  # Redirige a la lista de posts
end


  private

  # Strong parameters: permite solo estos campos
  def post_params
    params.require(:post).permit(:name, :title, :content)
  end
end
