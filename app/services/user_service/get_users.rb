module UserService
  class GetUsers
    def initialize(user_ids:)
      @user_ids = user_ids
    end

    def execute
      get_users
    end

    private

    def get_users
      Auth0.get_users(@user_ids)
    end
  end
end
