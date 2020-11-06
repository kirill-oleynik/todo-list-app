# frozen_string_literal: true

module API
  class CommentsController < ApplicationController
    before_action :find_entity, only: %i[show update destroy]

    def show
      if entity.user == current_user
        render json: entity, status: 200
      else
        head 422
      end
    end

    def create
      command = CreateComment.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
      else
        render json: command.errors, status: 422
      end
    end

    private

    def create_params
      params.require(:comment).permit(:title, :task_id)
    end
  end
end
