# frozen_string_literal: true

module UserService
  class Register < ApplicationService
    def initialize(user_id, role)
      @user_id = user_id
      @role = role
    end

    def call
      register
    end

    private

    def register
      Auth0.register(@user_id, @role)
    end
  end
end
