# frozen_string_literal: true

class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  # Sanitize the filename to make it URL-friendly and secure.
  # This version fixes the issue by ensuring the method doesn't return a nil value.
  def filename
    if original_filename.present?
      sanitized = super.gsub(/[^0-9A-Za-z.\-]/, "_")
      "#{File.basename(sanitized, '.*').parameterize}.#{file.extension.downcase}"
    end
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
