class AppointmentsController < ApplicationController
  before_action :is_client, only: [:create]

  # GET /appointments
  def index; end

  # POST /appointments
  def create; end

  # DELETE /appointments/1
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def is_client
    unless @user_roles.include?('client')
      response = {
        message: 'user is not a client'
      }

      render json: response, status: :forbidden
    end
  end

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:appointment).permit(:availability_id)
  end
end
