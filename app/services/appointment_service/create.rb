# frozen_string_literal: true

module AppointmentService
  class Create
    def initialize(client_id:, availability_id:)
      @client_id = client_id
      @availability_id = availability_id
    end

    def execute
      Appointment.create!(client_id: @client_id, availability_id: @availability_id)
    end
  end
end
