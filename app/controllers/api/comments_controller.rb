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
  end
end
