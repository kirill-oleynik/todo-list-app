# frozen_string_literal: true

FactoryBot.define do
  factory :task do |t|
    t.title { Faker::Lorem.sentence }
    t.done { Faker::Boolean.boolean(true_ratio: 0.5) }
    t.project { create(:project) }
  end

  factory :task_with_attachment, parent: :task do |t|
    t.attachment do
      Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/upload_example_file.txt')))
    end
  end
end
