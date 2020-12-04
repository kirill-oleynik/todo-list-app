# frozen_string_literal: true

# Wraps task attachment upload algorithm
class UploadTaskAttachment
  prepend SimpleCommand
  def initialize(user, params = {})
    @user = user
    @task_id = params[:task_id]
    @attachment = params[:attachment]
  rescue NoMethodError
    @task_id = @attachment = nil
  end

  def call
    return unless task

    if user.tasks.include? task
      task.attachment = attachment
      task&.attachment&.file&.exists? && task
    else
      errors.add(:user, 'NotAuthorized')
    end
  end

  private

  attr_reader :user, :task_id, :attachment

  def task
    @task ||= Task.find(task_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(:task, 'NotFound')
  end

  def attachment_valid?
    task.attachment.extension_whitelist.include? File.basename(attachment).split('.').last.downcase
  end
end
