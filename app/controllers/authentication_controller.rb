# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def authenticate
    command = AuthenticateUser.call(email: auth_params[:email], password: auth_params[:password])
    if command.success?
      render json: command.result, status: 201
    else
      render json: { errors: command.errors }, status: 401
    end
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
