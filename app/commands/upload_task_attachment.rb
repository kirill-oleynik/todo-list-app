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
    return unless [task, user_task_owner?, attachment, allowed_attachment?].all?

    task.attachment = attachment
    task.attachment&.file&.exists? && task
  end

  private

  attr_reader :user, :task_id, :attachment

  def task
    @task ||= Task.find(task_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(:task, 'NotFound')
  end

  def allowed_attachment?
    return true if allowed_extensions.include? attachment_extension

    errors.add(:file, 'NotSupported')
  end

  def allowed_extensions
    AttachmentUploader.new.extension_whitelist
  end

  def attachment_extension
    File.basename(attachment).split('.').last.downcase
  end

  def user_task_owner?
    return unless task.class == Task
    return true if user.tasks.include? task

    errors.add(:user, 'NotAuthorized')
  end
end
