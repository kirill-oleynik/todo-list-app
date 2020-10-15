# frozen_string_literal: true

# Todo-List entity
class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :title, presence: true
end
