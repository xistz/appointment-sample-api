require 'rails_helper'

RSpec.describe AppointmentService::Create, type: :model do
  fp_id = 'fp_1'
  client_id = 'client_1'
  from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

  it 'creates an appointment when availability exists' do
    availability_id = AvailabilityService::Create.new(fp_id: fp_id, from: from).execute

    expect { AppointmentService::Create.new(client_id: client_id, availability_id: availability_id).execute }.not_to raise_error
  end

  it 'returns error when availability does not exist' do
    expect { AppointmentService::Create.new(client_id: client_id, availability_id: 'invalid_id').execute }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'returns error when availability already has an appointment' do
    availability_id = AvailabilityService::Create.new(fp_id: fp_id, from: from).execute
    AppointmentService::Create.new(client_id: client_id, availability_id: availability_id).execute

    expect { AppointmentService::Create.new(client_id: 'client_2', availability_id: availability_id).execute }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
