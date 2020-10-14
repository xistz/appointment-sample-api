# frozen_string_literal: true

module AvailabilityService
  class SearchByTime
    def initialize(at:)
      @at = at
    end

    def execute
      Availability.where(from: @at)
    end
  end
end
