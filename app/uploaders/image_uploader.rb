# app/uploaders/image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base
  # Incluye MiniMagick para procesamiento
  include CarrierWave::MiniMagick

  storage :file

  # Define dónde se guardarán los archivos
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Crea una versión más pequeña de la imagen
  version :thumb do
    process resize_to_fill: [ 100, 100 ]
  end

  # Permite cualquier formato de imagen
  def extension_allowlist
    nil
  end
end
