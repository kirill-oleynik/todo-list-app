# frozen_string_literal: true

# Wraps new task creation algorithm
class UpdateComment
  prepend SimpleCommand
  def initialize(user, comment, attributes = {})
    @user = user
    @comment = comment
    @title = attributes.fetch(:title) { nil }
  rescue NoMethodError
    @title = nil
  end

  def call
    return unless [title_valid?, user.comments.include?(comment)].all?
    return comment if comment.update(title: title)

    comment.errors.map { |err, desc| errors.add(err, desc) }
  end

  private

  attr_reader :user, :comment, :title

  def title_valid?
    title.is_a?(String) && !title.empty? ? true : errors.add(:title, 'Invalid')
  end
end
