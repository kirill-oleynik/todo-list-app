# frozen_string_literal: true

module API
  class ProjectsController < ApplicationController
    before_action :find_entity, only: %i[show update destroy]

    def show
      render json: entity, status: 201
    end

    def create
      command = CreateProject.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
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
  end
end
