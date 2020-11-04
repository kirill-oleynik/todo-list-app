# frozen_string_literal: true

FactoryBot.define do
  factory :comment do |t|
    t.title { Faker::Lorem.sentence }
    t.task { create(:task) }
  end
end
