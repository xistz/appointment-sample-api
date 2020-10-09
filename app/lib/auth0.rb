# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class Auth0
  def self.register(user_id, role)
    token = get_token

    role_id = get_role_id(role, token)

    assign_role(user_id, role_id, token)
  end

  def self.get_token
    url = URI("https://#{ENV['AUTH0_DOMAIN']}/oauth/token")
    data = {
      client_id: ENV['AUTH0_CLIENT_ID'],
      client_secret: ENV['AUTH0_CLIENT_SECRET'],
      audience: "https://#{ENV['AUTH0_DOMAIN']}/api/v2/",
      grant_type: 'client_credentials'
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request.body = data.to_json

    response = http.request(request)
    body = response.read_body

    result = JSON.parse(body)
    token = result['access_token']

    token
  end

  def self.get_role_id(role, token)
    url = URI("https://#{ENV['AUTH0_DOMAIN']}/api/v2/roles")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['authorization'] = "Bearer #{token}"

    response = http.request(request)
    body = response.read_body

    results = JSON.parse(body)

    results.each do |result|
      return result['id'] if result['name'] == role
    end
  end

  def self.assign_role(user_id, role_id, token)
    url = URI("https://#{ENV['AUTH0_DOMAIN']}/api/v2/users/#{CGI.escape(user_id)}/roles")

    data = {
      roles: [role_id]
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request['content-type'] = 'application/json'
    request['authorization'] = "Bearer #{token}"
    request.body = data.to_json

    response = http.request(request)

    unless response.is_a? Net::HTTPNoContent
      body = response.read_body
      result = JSON.parse(body)

      raise StandardError.new, result['message']
    end
  end
end
