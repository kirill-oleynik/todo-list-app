# frozen_string_literal: true

module API
  class TasksController < ApplicationController
    before_action :find_entity, only: %i[show update destroy]

    def show
      if entity.user == current_user
        render json: entity, status: 200
      else
        head 422
      end
    end

    def create
      command = CreateTask.call(current_user, task_params)
      if command.success?
        render json: command.result, status: 201
      else
        render json: command.errors, status: 422
      end
    end

    def destroy
      if current_user.tasks.include?(entity)
        entity.destroy
        head 200
      else
        head 422
      end
    end

    private

    def task_params
      params.require(:task).permit(:project_id, :title, :done)
    end
  end
end
