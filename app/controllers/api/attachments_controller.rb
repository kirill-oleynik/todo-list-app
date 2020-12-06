# frozen_string_literal: true

module API
  class AttachmentsController < ApplicationController
    def destroy
      command = DeleteTaskAttachment.call(current_user, destroy_params)
      if command.success?
        render json: command.result, status: 200
      else
        render json: command.errors, status: 422
      end
    end

    private

    def destroy_params
      params.require(:attachment).require(:task_id)
    end
  end
end
