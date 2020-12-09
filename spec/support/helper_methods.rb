# frozen_string_literal: true

module HelperMethods
  def mock_fog_storage
    Fog.mock!
    Fog.credentials = {
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_S3_REGION']
    }
    connection = Fog::Storage.new(provider: 'AWS')
    connection.directories.create(key: ENV['AWS_S3_BUCKET'])
  end

  def valid_attachment_file
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/upload_example_file.txt')))
  end

  def invalid_attachment_file
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/upload_example_file.rb')))
  end
end
