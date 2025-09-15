class Post < ApplicationRecord
 belongs_to :user  # Relación con el modelo User
  validates :title, presence: true  # El título es obligatorio
  validates :content, presence: true  # El contenido es obligatorio
  has_many :comments, dependent: :destroy
end
