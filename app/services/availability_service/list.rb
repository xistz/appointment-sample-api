# frozen_string_literal: true

module AvailabilityService
  class List
    def initialize(fp_id:, from:, to:)
      @fp_id = fp_id
      @from = from
      @to = to
    end

    def execute
      availabilities = Availability.where(fp_id: @fp_id, from: (@from..@to))

      availabilities
    end
  end
end
