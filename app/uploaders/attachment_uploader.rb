# frozen_string_literal: true

class AttachmentUploader < CarrierWave::Uploader::Base
  storage :fog
  def extension_whitelist
    %w[pdf txt rtf pages nubers docx xls jpg jpeg png gif]
  end
end
