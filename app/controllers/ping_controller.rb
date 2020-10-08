# frozen_string_literal: true

class PingController < ApplicationController
  def index
    response = {
      message: 'pong'
    }

    render json: response
  end
end
