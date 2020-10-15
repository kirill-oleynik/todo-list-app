# frozen_string_literal: true

FactoryBot.define do
  factory :task do |t|
    t.title { Faker::Lorem.sentence }
    t.done { Faker::Boolean.boolean(true_ratio: 0.5) }
    t.project { create(:project) }
  end
end
