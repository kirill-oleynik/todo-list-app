# frozen_string_literal: true

# require './app/uploaders/attachment_uploader.rb'
# TodoList task entity
class Task < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  delegate :user_id, to: :project
  delegate :user, to: :project
end
