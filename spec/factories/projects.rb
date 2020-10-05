# frozen_string_literal: true

FactoryBot.define do
  factory :project do |f|
    f.title { Faker::Lorem.sentence }
  end
end
