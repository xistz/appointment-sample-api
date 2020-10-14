# frozen_string_literal: true

module AvailabilityService
  class SearchByDate
    def initialize(from:, to:, client_id:)
      @from = from
      @to = to
      @client_id = client_id
    end

    def execute
      appointments = AppointmentService::List.new(user_id: @client_id, from: @from, to: @to).execute

      availabilities = Availability.free.where(from: (@from..@to)).where.not(from: appointments.pluck(:from))

      availabilities
    end
  end
end
