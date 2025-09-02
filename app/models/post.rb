class Post < ApplicationRecord
  # Validaciones para los campos name, title y content
  validates :name, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  # Relación con comentarios
  has_many :comments, dependent: :destroy  # Elimina los comentarios cuando se elimina el post
end
