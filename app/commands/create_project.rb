# frozen_string_literal: true

# Wraps new project creation algorithm
class CreateProject
  prepend SimpleCommand

  def initialize(user, title)
    @user = user
    @title = title
  end

  def call
    user.projects.create(title: title)
  end

  private

  attr_reader :title, :user
end
