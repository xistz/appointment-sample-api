# frozen_string_literal: true

module AvailabilityService
  class List
    def initialize(user_id:, from:, to:)
      @user_id = user_id
      @from = from
      @to = to
    end

    def execute
      availabilities = Availability.where(user_id: @user_id, from: (@from..@to))

      availabilities
    end
  end
end
