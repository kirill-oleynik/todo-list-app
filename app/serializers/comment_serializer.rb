# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :task_id, :user_id
end
