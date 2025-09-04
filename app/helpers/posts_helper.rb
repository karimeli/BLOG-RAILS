module PostsHelper
  # Método para unir las etiquetas de un post con comas
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end
end
