require 'rails_helper'

RSpec.describe AvailabilityService::Create, type: :model do
  dummy_id = 'dummy_id'

  it 'returns error when it is a sunday' do
    from = Time.current.change(day: 11, month: 10, year: 2020, hour: 10, min: 0)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'returns error when start time is before 1000 on a weekday' do
    from = Time.current.change(day: 12, month: 10, year: 2020, hour: 9, min: 0)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'returns error when start time is after 1730 on a weekday' do
    from = Time.current.change(day: 12, month: 10, year: 2020, hour: 18, min: 0)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'returns error when start time is before 1100 on a saturday' do
    from = Time.current.change(day: 10, month: 10, year: 2020, hour: 10, min: 0)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'returns error when start time is after 1430 on a saturday' do
    from = Time.current.change(day: 10, month: 10, year: 2020, hour: 15, min: 0)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'returns error when start time does not begin at the hour or half hour' do
    from = Time.current.change(day: 10, month: 10, year: 2020, hour: 14, min: 15)

    expect { AvailabilityService::Create.new(user_id: dummy_id, from: from).execute }.to raise_error(Availability::BadFromError)
  end

  it 'creates availability when from begins at the hour for a weekday' do
    from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

    AvailabilityService::Create.new(user_id: dummy_id, from: from).execute
    expect(Availability.count).to eq 1
  end

  it 'creates availability when from begins at the half hour for a weekday' do
    from = Time.current.change(day: 12, month: 10, year: 2020, hour: 17, min: 30)

    AvailabilityService::Create.new(user_id: dummy_id, from: from).execute
    expect(Availability.count).to eq 1
  end

  it 'creates availability when from begins at the hour for a saturday' do
    from = Time.current.change(day: 10, month: 10, year: 2020, hour: 11, min: 0o0)

    AvailabilityService::Create.new(user_id: dummy_id, from: from).execute
    expect(Availability.count).to eq 1
  end

  it 'creates availability when from begins at the half hour for a saturday' do
    from = Time.current.change(day: 10, month: 10, year: 2020, hour: 14, min: 30)

    AvailabilityService::Create.new(user_id: dummy_id, from: from).execute
    expect(Availability.count).to eq 1
  end
end
