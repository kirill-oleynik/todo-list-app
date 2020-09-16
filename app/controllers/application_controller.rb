# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  attr_reader :entity

  def find_entity
    head(404) unless (@entity = controller_name.classify.constantize.find_by_id(params[:id]))
  end
end
