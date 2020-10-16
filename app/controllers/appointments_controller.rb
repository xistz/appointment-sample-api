class AppointmentsController < SecuredController
  before_action :is_client, only: [:create]

  # GET /appointments
  def index
    from = DateTime.parse(index_params[:from])
    to = DateTime.parse(index_params[:to])

    appointments = AppointmentService::List.new(user_id: @user_id, from: from, to: to).execute

    user_ids = appointments.pluck(:client_id, :fp_id).flatten
    users = UserService::GetUsers.new(user_ids: user_ids).execute

    render json: AppointmentSerializer::Index.new(appointments, { params: { users: users } }).serializable_hash
  end

  # POST /appointments
  def create
    availability_id = create_params[:availability_id]

    AppointmentService::Create.new(client_id: @user_id, availability_id: availability_id).execute

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
  def destroy
    id = destroy_params[:id]

    AppointmentService::Delete.new(user_id: @user_id, appointment_id: id).execute

    response = {
      message: 'deleted appointment'
    }

    render json: response
  rescue ActiveRecord::RecordNotFound => e
    response = {
      message: e.message
    }

    render json: response, status: :not_found
  end

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

  def index_params
    params.permit(:from, :to)
  end

  def destroy_params
    params.permit(:id)
  end
end
