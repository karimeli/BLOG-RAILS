class AddImageToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :image, :string
  end
end
