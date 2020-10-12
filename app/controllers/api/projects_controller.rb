# frozen_string_literal: true

module API
  class ProjectsController < ApplicationController
    before_action :find_entity, only: %i[show update destroy]
    def index
      entities = current_user.projects.where('title LIKE ?', "%#{filter_params[:title]}%")
      render json: { projects: entities }, status: 200
    end

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

    def filter_params
      params.require(:projects).require(:filters).permit(:title)
    end

    def create_params
      params.require(:project).require(:title)
    end

    def update_params
      params.require(:project).permit(:title)
    end
  end
end
