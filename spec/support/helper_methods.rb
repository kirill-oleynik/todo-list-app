# frozen_string_literal: true

module HelperMethods
  def valid_attachment_file
    File.open('spec/support/upload_example_file.txt', 'r')
  end

  def invalid_attachment_file
    File.open('spec/support/upload_example_file.rb', 'r')
  end
end
