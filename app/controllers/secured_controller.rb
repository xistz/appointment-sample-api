class SecuredController < ApplicationController
  before_action :authorize_request

  private

  def authorize_request
    @user_id, @user_roles = AuthorizationService.new(request.headers).authenticate_request!
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { message: "not authorized" }, status: :unauthorized
  end
end