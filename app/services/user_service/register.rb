# frozen_string_literal: true

module UserService
  class Register < Base
    def initialize(user_id:, role:)
      @user_id = user_id
      @role = role
      @token = get_token
    end

    def execute
      role_id = get_role_id

      assign_role(role_id)
    end

    private

    def get_role_id
      url = URI("https://#{ENV['AUTH0_DOMAIN']}/api/v2/roles")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request['authorization'] = "Bearer #{@token}"

      response = http.request(request)
      body = response.read_body

      results = JSON.parse(body)

      results.each do |result|
        return result['id'] if result['name'] == @role
      end
    end

    def assign_role(role_id)
      url = URI("https://#{ENV['AUTH0_DOMAIN']}/api/v2/users/#{CGI.escape(@user_id)}/roles")

      data = {
        roles: [role_id]
      }

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request['content-type'] = 'application/json'
      request['authorization'] = "Bearer #{@token}"
      request.body = data.to_json

      response = http.request(request)

      unless response.is_a? Net::HTTPNoContent
        body = response.read_body
        result = JSON.parse(body)

        raise StandardError.new, result['message']
      end
    end
  end
end
