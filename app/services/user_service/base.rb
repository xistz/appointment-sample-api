module UserService
  class Base
    private

    def get_token
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
  end
end
