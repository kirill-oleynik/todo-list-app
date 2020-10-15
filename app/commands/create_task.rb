# frozen_string_literal: true

# Wraps new task creation algorithm
class CreateTask
  prepend SimpleCommand
  DEFAULTS = [nil, '', false].freeze

  def initialize(user, attributes = {})
    @user = user
    @project_id = attributes.fetch(:project_id) { nil }
    @title = attributes.fetch(:title) { '' }
    @done = attributes.fetch(:done) { false }
  rescue NoMethodError
    @project_id, @title, @done = *DEFAULTS
  end

  def call
    if user.projects.exists?(project_id)
      task = user.projects.find(project_id).tasks.create(title: title, done: done)
      task
    else
      errors.add(:project, 'Not found')
      nil
    end
  end

  private

  attr_reader :user, :project_id, :title, :done
end
