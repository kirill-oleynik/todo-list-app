# frozen_string_literal: true

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :tasks
end
