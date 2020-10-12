class AvailabilitiesController < SecuredController
  # before_action :set_availability, only: [:destroy]
  before_action :is_financial_planner, only: [:create]

  # GET /availabilities
  def index
    from = DateTime.parse(index_params[:from])
    to = DateTime.parse(index_params[:to])

    availabilities = AvailabilityService::List.new(user_id: @user_id, from: from, to: to).execute

    render json: AvailabilitySerializer.new(availabilities).serializable_hash
  end

  # POST /availabilities
  def create
    from = DateTime.parse(create_params[:from])

    id = AvailabilityService::Create.new(user_id: @user_id, from: from).execute

    response = {
      id: id,
      message: 'created availability'
    }

    render json: response, status: :created
  rescue Availability::BadFromError, Date::Error => e
    response = {
      message: e.message
    }

    render json: response, status: :bad_request
  end

  # DELETE /availabilities/1
  def destroy
    @availability.destroy

    response = {
      message: 'deleted availability'
    }

    render json: response
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_availability
    @availability = Availability.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:availability).permit(:from)
  end

  def index_params
    params.permit(:from, :to)
  end

  def is_financial_planner
    unless @user_roles.include?('financial planner')
      response = {
        message: 'user is not a financial planner'
      }

      render json: response, status: :forbidden
    end
  end
end
