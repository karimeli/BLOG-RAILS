class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  mount_uploader :image, ImageUploader  # Asocia el uploader de imagen con el campo 'image'

  validates :body, presence: true  # Asegúrate de que el comentario tenga contenido
end
