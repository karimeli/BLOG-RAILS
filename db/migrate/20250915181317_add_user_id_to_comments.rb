class AddUserIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user, null: true, foreign_key: true  # Permitir valores nulos
  end
end
