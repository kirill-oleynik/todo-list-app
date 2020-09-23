# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.unique.email }
    f.password { 'password' }
  end
end
