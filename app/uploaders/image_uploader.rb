# app/uploaders/image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base
  storage :file  # Puedes cambiar esto a :fog si estás utilizando un servicio como Amazon S3

  # Define el tipo de archivo que quieres permitir
  def extension_whitelist
    %w[jpg jpeg gif png bmp]
  end
end
