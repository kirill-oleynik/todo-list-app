# frozen_string_literal: true

module API
  class ProjectsController < ApplicationController
    def create
      command = CreateProject.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
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
