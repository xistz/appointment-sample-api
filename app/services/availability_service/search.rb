# frozen_string_literal: true

module AvailabilityService
  class Search
    def initialize(from: nil, to: nil, at: nil)
      @from = from
      @to = to
      @at = at
    end

    def execute
      availabilities = if @from.present? && @to.present?
        Availability.where(from: (@from..@to))
      else
        Availability.where(from: @at)
      end

      availabilities
    end
  end
end
