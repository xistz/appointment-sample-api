class HealthCheckController < ApplicationController
  def index
    @response = {
      status: "UP"
    }

    render json: @response
  end
end
