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
      command = CreateTask.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
      else
        render json: command.errors, status: 422
      end
    end

    def update
      return head 422 unless current_user.tasks.include?(entity)

      if entity.update(update_params)
        render json: entity, status: 200
      else
        render json: entity.errors, staus: 422
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

    def create_params
      params.require(:task).permit(:project_id, :title, :done)
    end

    def update_params
      params.require(:task).permit(:title, :done)
    end
  end
end
