# frozen_string_literal: true

class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  # Versión corregida y final del método filename
  def filename
    if original_filename.present?
      "#{File.basename(original_filename, '.*').parameterize}#{File.extname(original_filename).downcase}"
    else
      super
    end
  end

  version :thumb do
    process resize_to_fill: [ 118, 100 ]
  end

  version :content do
    process resize_to_limit: [ 800, 800 ]
  end

  # Permite cualquier tipo de archivo de imagen
  def extension_allowlist
    # Al devolver nil, se eliminan las restricciones de formato.
    nil
  end
end
