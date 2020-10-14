class AvailabilitiesController < SecuredController
  before_action :is_financial_planner, only: %i[index create destroy]
  before_action :is_client, only: [:search]

  # GET /availabilities
  def index
    from = DateTime.parse(index_params[:from])
    to = DateTime.parse(index_params[:to])

    availabilities = AvailabilityService::List.new(fp_id: @user_id, from: from, to: to).execute

    render json: AvailabilitySerializer::Index.new(availabilities).serializable_hash
  end

  # GET /availabilities/search
  def search
    from = search_params[:from]
    to = search_params[:to]
    at = search_params[:at]

    if from.present? && to.present?
      availabilities = AvailabilityService::SearchByDate.new(from: from, to: to, client_id: @user_id).execute

      render json: AvailabilitySerializer::SearchByDate.new(availabilities).serializable_hash
    elsif at.present?
    else
      response = { message: 'query by date requires from and to, query by time requires at' }

      render json: response, status: :bad_request
    end
  end

  # POST /availabilities
  def create
    from = DateTime.parse(create_params[:from])

    id = AvailabilityService::Create.new(fp_id: @user_id, from: from).execute

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
    id = delete_params[:id]

    AvailabilityService::Delete.new(fp_id: @user_id, availability_id: id).execute

    response = {
      message: 'deleted availability'
    }

    render json: response
  rescue ActiveRecord::RecordNotFound => e
    response = {
      message: e.message
    }

    render json: response, status: :not_found
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:availability).permit(:from)
  end

  def index_params
    params.permit(:from, :to)
  end

  def delete_params
    params.permit(:id)
  end

  def search_params
    params.permit(:from, :to, :at)
  end

  def is_financial_planner
    unless @user_roles.include?('financial planner')
      response = {
        message: 'user is not a financial planner'
      }

      render json: response, status: :forbidden
    end
  end

  def is_client
    unless @user_roles.include?('client')
      response = {
        message: 'user is not a client'
      }

      render json: response, status: :forbidden
    end
  end
end
