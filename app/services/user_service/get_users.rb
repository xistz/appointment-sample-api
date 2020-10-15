module UserService
  class GetUsers < Base
    def initialize(user_ids:)
      @user_ids = user_ids
      @token = get_token
    end

    def execute
      get_users
    end

    private

    def get_users
      url = URI("https://#{ENV['AUTH0_DOMAIN']}/api/v2/users")
      params =  {
        fields: 'user_id,name,picture',
        include_fields: true,
        search_engine: 'v3',
        q: "user_id:(#{@user_ids.join(' OR ')})"
      }
      url.query = URI.encode_www_form(params)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request['authorization'] = "Bearer #{@token}"

      response = http.request(request)
      body = response.read_body

      results = JSON.parse(body)

      # convert array of users to hash
      users = {}
      results.each do |result|
        user_id = result['user_id']
        name = result['name']
        picture = result['picture']

        users[user_id] = {
          name: name,
          picture: picture
        }
      end

      users
    end
  end
end
