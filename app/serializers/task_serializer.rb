# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :done,
             :project_id,
             :user_id,
             :attachment_url,
             :attachment_filename

  def attachment_filename
    object.attachment&.file&.filename
  end
end
