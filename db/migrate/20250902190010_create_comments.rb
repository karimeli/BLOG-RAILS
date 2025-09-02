class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :commenter  # Nombre del comentarista
      t.text :body         # Cuerpo del comentario
      t.references :post, null: false, foreign_key: true  # Referencia al post al que pertenece el comentario

      t.timestamps
    end
  end
end
