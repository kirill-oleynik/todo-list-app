# frozen_string_literal: true

# TodoList task entity
class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  delegate :user_id, to: :project
  delegate :user, to: :project
end
