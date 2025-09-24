# app/uploaders/ckeditor_picture_uploader.rb
# frozen_string_literal: true

class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  def filename
    # Sanitiza el nombre del archivo para eliminar caracteres especiales
    "#{super.gsub(/[^0-9A-Za-z.\-]/, '_')}" if original_filename
  end

  version :thumb do
    process resize_to_fill: [ 118, 100 ]
  end

  version :content do
    process resize_to_limit: [ 800, 800 ]
  end

  def extension_allowlist
    Ckeditor.image_file_types
  end
end
