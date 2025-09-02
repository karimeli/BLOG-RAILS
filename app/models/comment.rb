class Comment < ApplicationRecord
  belongs_to :post  # Establece la relación con Post
end
