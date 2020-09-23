# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  private

  attr_reader :entity

  def authorize_request
    @current_user = AuthorizeRequest.call(request.headers).result
    render json: command.errrors, status: 401 unless @current_user
  end

  def find_entity
    head(404) unless (@entity = controller_name.classify.constantize.find_by_id(params[:id]))
  end
end
