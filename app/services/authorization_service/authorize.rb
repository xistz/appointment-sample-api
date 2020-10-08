# frozen_string_literal: true

module AuthorizationService
  class Authorize < ApplicationService
    def initialize(headers = {})
      @headers = headers
    end

    def call
      user_id, user_roles = verify_token

      [user_id, user_roles]
    end

    private

    def authorization_headers
      @headers['Authorization']
    end

    def http_token
      authorization_headers.split(' ').last if authorization_headers.present?
    end

    def verify_token
      JsonWebToken.verify(http_token)
    end
  end
end
