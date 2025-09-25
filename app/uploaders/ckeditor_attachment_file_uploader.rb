# frozen_string_literal: true

require "carrierwave"

class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  storage :file

  def store_dir
    "uploads/ckeditor/attachments/#{model.id}"
  end

  # Permite cualquier tipo de archivo adjunto.
  def extension_allowlist
    # Al devolver nil, se eliminan las restricciones de formato.
    nil
  end
end
