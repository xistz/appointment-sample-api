require 'rails_helper'

RSpec.describe AppointmentService::List, type: :model do
  fp_id = 'fp_1'
  client_id = 'client_1'
  from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)
  to = from.change(hour: 17, min: 30)

  before do
    AvailabilityService::Create.new(fp_id: fp_id, from: from).execute
    AvailabilityService::Create.new(fp_id: fp_id, from: from.change(hour: 11, min: 0)).execute
    AvailabilityService::Create.new(fp_id: fp_id, from: from.change(hour: 17, min: 30)).execute
  end

  it 'returns no appoinments' do
    expect(AppointmentService::List.new(user_id: client_id, from: from, to: to).execute.count).to eq 0
    expect(AppointmentService::List.new(user_id: fp_id, from: from, to: to).execute.count).to eq 0
  end

  it 'returns 1 appointment' do
    availability_id = AvailabilityService::Create.new(fp_id: fp_id, from: from.change(hour: 12, min: 0)).execute

    AppointmentService::Create.new(client_id: client_id, availability_id: availability_id).execute

    expect(AppointmentService::List.new(user_id: client_id, from: from, to: to).execute.count).to eq 1
    expect(AppointmentService::List.new(user_id: fp_id, from: from, to: to).execute.count).to eq 1
  end

  it 'returns 2 appointments for client, and 1 each for fp' do
    availability_id_1 = AvailabilityService::Create.new(fp_id: fp_id, from: from.change(hour: 12, min: 0)).execute
    AppointmentService::Create.new(client_id: client_id, availability_id: availability_id_1).execute

    availability_id_2 = AvailabilityService::Create.new(fp_id: 'fp_2', from: from.change(hour: 13, min: 0)).execute
    AppointmentService::Create.new(client_id: client_id, availability_id: availability_id_2).execute

    expect(AppointmentService::List.new(user_id: client_id, from: from, to: to).execute.count).to eq 2
    expect(AppointmentService::List.new(user_id: fp_id, from: from, to: to).execute.count).to eq 1
    expect(AppointmentService::List.new(user_id: 'fp_2', from: from, to: to).execute.count).to eq 1
  end
end
