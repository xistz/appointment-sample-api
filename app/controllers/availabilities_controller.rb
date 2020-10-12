class AvailabilitiesController < SecuredController
  # before_action :set_availability, only: [:destroy]
  before_action :is_financial_planner, only: [:create]

  # GET /availabilities
  def index
    @availabilities = Availability.all

    render json: @availabilities
  end

  # POST /availabilities
  def create
    from = DateTime.parse(create_params[:from])

    id = AvailabilityService::Create.call(@user_id, from)

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
      message: "deleted availability"
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

  def is_financial_planner
    unless @user_roles.include?('financial planner')
      response = {
        message: 'user is not a financial planner'
      }

      render json: response, status: :forbidden
    end
  end
end
