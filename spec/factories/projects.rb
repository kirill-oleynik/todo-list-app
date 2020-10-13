# frozen_string_literal: true

FactoryBot.define do
  factory :project do |p|
    p.title { Faker::Lorem.sentence }
    p.user { create(:user) }
  end
end

def project_with_tasks(tasks_count = 10)
  create(:project) do |p|
    create_list(:task, tasks_count, project: p)
  end
end
