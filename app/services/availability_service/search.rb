# frozen_string_literal: true

module AvailabilityService
  class Search
    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def execute
      availabilities = Availability.where(from: (@from..@to))

      availabilities
    end
  end
end
