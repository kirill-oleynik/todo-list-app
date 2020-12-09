# frozen_string_literal: true

# todolists owner entity
class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy
  has_many :tasks
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true

  def tasks
    Task.where(project: projects.ids)
  end

  def comments
    Comment.where(task: tasks.ids)
  end
end
