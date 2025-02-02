# frozen_string_literal: true

class SecuredController < ApplicationController
  before_action :authorize_request

  private

  def authorization_token
    headers = request.headers

    auth_header = headers['Authorization']

    render json: { message: 'not authorized' }, status: :unauthorized unless auth_header.present?

    token = auth_header.split(' ').last

    render json: { message: 'not authorized' }, status: :unauthorized unless token.present?

    token
  end

  def authorize_request
    @user_id, @user_roles = AuthorizationService::Authorize.new(authorization_token: authorization_token).execute
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { message: 'not authorized' }, status: :unauthorized
  end
end
