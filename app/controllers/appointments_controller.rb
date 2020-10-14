class AppointmentsController < ApplicationController
  before_action :is_client, only: [:create]

  # GET /appointments
  def index; end

  # POST /appointments
  def create
    availability_id  = create_params[:availability_id]

    AppointmentService::Create.new(client_id: @user_id, availability_id: availability_id)

    response = {
      message: 'created appointment'
    }

    render json: response, status: :created
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
    response = {
      message: e.message
    }

    render json: response, status: :bad_request
  end

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
