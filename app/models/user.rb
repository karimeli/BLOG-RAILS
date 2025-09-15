class User < ApplicationRecord
  # Agregar los módulos de devise que necesitas
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
end
