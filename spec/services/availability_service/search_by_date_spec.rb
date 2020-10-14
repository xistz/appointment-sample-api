require 'rails_helper'

RSpec.describe AvailabilityService::SearchByDate, type: :model do
  from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)
  to = Time.current.change(day: 12, month: 10, year: 2020, hour: 17, min: 30)

  it 'returns 3 availabilities' do
    AvailabilityService::Create.new(fp_id: 'fp_1', from: from.change(hour: 11, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'fp_2', from: from.change(hour: 17, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'fp_3', from: from.change(hour: 17, min: 30)).execute

    expect(AvailabilityService::SearchByDate.new(from: from, to: to, client_id: 'client_1').execute.count).to eq 3
  end

  it 'returns 0 availabilities' do
    expect(AvailabilityService::SearchByDate.new(from: from, to: to, client_id: 'client_1').execute.count).to eq 0
  end

  it 'excludes availabilities that have appointments' do
    AvailabilityService::Create.new(fp_id: 'fp_1', from: from.change(hour: 11, min: 0)).execute
    availability_id = AvailabilityService::Create.new(fp_id: 'fp_2', from: from.change(hour: 17, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'fp_3', from: from.change(hour: 17, min: 30)).execute

    AppointmentService::Create.new(client_id: 'client_2', availability_id: availability_id).execute

    expect(AvailabilityService::SearchByDate.new(from: from, to: to, client_id: 'client_1').execute.count).to eq 2
  end

  it 'excludes times that client has an appointment' do
    AvailabilityService::Create.new(fp_id: 'fp_1', from: from.change(hour: 11, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'fp_2', from: from.change(hour: 11, min: 0)).execute
    availability_id = AvailabilityService::Create.new(fp_id: 'fp_2', from: from.change(hour: 17, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'fp_3', from: from.change(hour: 17, min: 30)).execute

    AppointmentService::Create.new(client_id: 'client_1', availability_id: availability_id).execute

    expect(AvailabilityService::SearchByDate.new(from: from, to: to, client_id: 'client_1').execute.count).to eq 2
  end
end
