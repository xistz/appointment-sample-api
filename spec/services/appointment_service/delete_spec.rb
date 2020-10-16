require 'rails_helper'

RSpec.describe AppointmentService::Delete, type: :model do
  fp_id = 'fp_1'
  client_id = 'client_1'
  from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

  let(:appointment) do
    availability_id = AvailabilityService::Create.new(fp_id: fp_id, from: from).execute
    AppointmentService::Create.new(client_id: client_id, availability_id: availability_id).execute
  end

  context 'deletes appointment when it belongs to user' do
    it 'belongs to client' do
      expect { AppointmentService::Delete.new(user_id: client_id, appointment_id: appointment.id).execute }.not_to raise_error
      expect(Appointment.count).to eq 0
    end

    it 'belongs to fp' do
      expect { AppointmentService::Delete.new(user_id: fp_id, appointment_id: appointment.id).execute }.not_to raise_error
      expect(Appointment.count).to eq 0
    end
  end

  it 'returns error when appointment does not belong to user' do
    expect { AppointmentService::Delete.new(user_id: 'client_2', appointment_id: appointment.id).execute }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Appointment.count).to eq 1
  end
end
