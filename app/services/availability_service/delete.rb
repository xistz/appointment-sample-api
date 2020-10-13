# frozen_string_literal: true

module AvailabilityService
  class Delete
    def initialize(user_id:, id:)
      @user_id = user_id
      @id = id
    end

    def execute
      availability = Availability.find_by!(id: @id, user_id: @user_id)

      availability.destroy
    end
  end
end
