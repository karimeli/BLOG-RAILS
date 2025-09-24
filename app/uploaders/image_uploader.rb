# app/uploaders/image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  # Define el tipo de archivo que quieres permitir
  def extension_allowlist
    %w[jpg jpeg gif png bmp]
  end
end
