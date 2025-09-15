class Post < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
end
