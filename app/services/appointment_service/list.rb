# frozen_string_literal: true

module AppointmentService
  class List
    def initialize(user_id:, from:, to:)
      @user_id = user_id
      @from = from
      @to = to
    end

    def execute
      appoinments_at_datetime = Appointment.joins(:availability).where(availabilities: { from: (@from..@to) }).order('availabilities.from')
      user_appointments = appoinments_at_datetime.where(client_id: @user_id).or(appoinments_at_datetime.where(availabilities: { fp_id: @user_id }))

      user_appointments
    end
  end
end
