# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    before_action :find_entity, only: %i[show update destroy]
    def create
      user = User.new(create_params)
      if user.save
        render json: user, status: 201
      else
        render json: user.errors, status: 422
      end
    end

    def show
      render json: entity, status: 200
    end

    def update
      if entity.update(update_params)
        render json: entity, status: 200
      else
        render json: entity.errors, status: 422
      end
    end

    def destroy
      entity.destroy
      head 204
    end

    private

    def create_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_params
      params.require(:user).permit(:name, :email)
    end
  end
end
