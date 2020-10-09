# frozen_string_literal: true

module API
  class ProjectsController < ApplicationController
    before_action :find_entity, only: %i[show update destroy]

    def show
      if entity.user == current_user
        render json: entity, status: 200
      else
        head 422
      end
    end

    def create
      command = CreateProject.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
      else
        head 422
      end
    end

    def update
      if entity.user == current_user
        if entity.update(update_params)
          render json: entity, status: 200
        else
          render json: entity.errors, status: 422
        end
      else
        head 422
      end
    end

    def destroy
      if entity.user == current_user
        entity.destroy
        head 204
      else
        head 422
      end
    end

    private

    def create_params
      params.require(:project).require(:title)
    end

    def update_params
      params.require(:project).permit(:title)
    end
  end
end
