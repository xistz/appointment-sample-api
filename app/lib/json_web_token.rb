# frozen_string_literal: true

require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    auth_payload, = JWT.decode(token, nil,
                               true, # Verify the signature of this token
                               algorithm: 'RS256',
                               iss: "https://#{ENV['AUTH0_DOMAIN']}/",
                               verify_iss: true,
                               aud: ENV['AUTH0_AUDIENCE'],
                               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end

    [auth_payload['sub'], auth_payload["#{ENV['AUTH0_NAMESPACE']}/roles"]]
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("https://#{ENV['AUTH0_DOMAIN']}/.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end
end