# frozen_string_literal: true

# Task comment entity
class Comment < ApplicationRecord
  belongs_to :task
  validates :title, presence: true
  delegate :user_id, to: :task
  delegate :user, to: :task
end
