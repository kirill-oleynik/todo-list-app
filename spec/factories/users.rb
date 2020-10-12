# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.unique.email }
    f.password { 'password' }
  end
end

def user_with_projects(projects_count = 10)
  create(:user) do |user|
    create_list(:project, projects_count, user: user)
  end
end
