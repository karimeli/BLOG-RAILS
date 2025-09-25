# app/uploaders/image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  # Define el tipo de archivo que quieres permitir.
  # Devolver un array vacío o nil permite todos los formatos.
  def extension_allowlist
    nil
  end
end
