# frozen_string_literal: true

class RegisterController < SecuredController
  before_action :is_new_user

  def create
    role = new_params[:role]

    UserService::Register.new(@user_id, role).execute

    response = {
      message: "registered as a #{role}"
    }

    render json: response, status: :created
  rescue StandardError => e
    puts e
    response = {
      message: e.message
    }

    render json: response, status: :internal_server_error
  end

  private

  def is_new_user
    if @user_roles.present?
      response = {
        message: "user has already registered as a #{@user_roles.first}"
      }

      render json: response, status: :bad_request
    end
  end

  def new_params
    params.require(:register).permit(:role)
  end
end
