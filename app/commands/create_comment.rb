# frozen_string_literal: true

# Wraps new task creation algorithm
class CreateComment
  prepend SimpleCommand
  def initialize(user, attributes = {})
    @user = user
    @task_id = attributes.fetch(:task_id) { nil }
    @title = attributes.fetch(:title) { nil }
  rescue NoMethodError
    @title = @task_id = nil
  end

  def call
    return unless [title_valid?, task_valid?].all?

    comment = Comment.new(title: title, task_id: task_id)
    return comment if comment.save

    comment.errors.map { |err, desc| errors.add(err, desc) }
  end

  private

  attr_reader :user, :task_id, :title

  def title_valid?
    title.is_a?(String) && !title.empty? ? true : errors.add(:title, 'Invalid')
  end

  def task_valid?
    user.tasks.map(&:id).include?(task_id) ? true : errors.add(:task, 'Not found') && false
  end
end
