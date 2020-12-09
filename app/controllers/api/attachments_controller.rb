# frozen_string_literal: true

module API
  class AttachmentsController < ApplicationController
    def create
      # create_params[:attachment].class == String
      command = UploadTaskAttachment.call(current_user, create_params)
      if command.success?
        render json: command.result, status: 201
      else
        render json: command.errors, status: 422
      end
    end

    def destroy
      command = DeleteTaskAttachment.call(current_user, destroy_params)
      if command.success?
        render json: command.result, status: 200
      else
        render json: command.errors, status: 422
      end
    end

    private

    def create_params
      params.require(:attachment).permit(:task_id, :attachment)
    end

    def destroy_params
      params.require(:attachment).require(:task_id)
    end
  end
end
