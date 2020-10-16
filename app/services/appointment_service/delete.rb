# frozen_string_literal: true

module AppointmentService
  class Delete
    def initialize(user_id:, appointment_id:)
      @user_id = user_id
      @appointment_id = appointment_id
    end

    def execute
      appointment = Appointment.joins(:availability).find(@appointment_id)

      unless appointment.client_id == @user_id || appointment.fp_id == @user_id
        raise ActiveRecord::RecordNotFound.new "Couldn't find appointment with 'id'=#{@appointment_id}"
      end

      appointment.destroy
    end
  end
end
