require 'rails_helper'

RSpec.describe AvailabilityService::Delete, type: :model do
  dummy_id = 'test_1'
  from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

  it 'returns success when deleting existing availability' do
    availability = Availability.create(user_id: dummy_id, from: from.change(hour: 11, min: 0))

    expect { AvailabilityService::Delete.new(user_id: dummy_id, id: availability.id).execute }.not_to raise_error
  end

  it 'returns error when deleting non-existent availability' do
    availability =  Availability.create(user_id: 'test_2', from: from.change(hour: 17, min: 0))

    expect { AvailabilityService::Delete.new(user_id: dummy_id, id: availability.id).execute }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
