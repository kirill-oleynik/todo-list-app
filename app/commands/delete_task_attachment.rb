# frozen_string_literal: true

# Wraps task attachment deletion algorithm
class DeleteTaskAttachment
  prepend SimpleCommand
  def initialize(user, task_id)
    @user = user
    @task_id = task_id
  end

  def call
    return unless task
    return unless user_task_owner?

    task.attachment&.remove!
    task
  end

  private

  attr_reader :user, :task_id
  def task
    @task ||= Task.find(task_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(:task, 'NotFound')
  end

  def user_task_owner?
    if user.tasks.include?(task)
      true
    else
      errors.add(:user, 'NotAuthorized')
      false
    end
  end
end
