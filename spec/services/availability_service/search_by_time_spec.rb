require 'rails_helper'

RSpec.describe AvailabilityService::SearchByTime, type: :model do
  base = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

  before do
    AvailabilityService::Create.new(fp_id: 'test_1', from: base.change(hour: 11, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'test_2', from: base.change(hour: 11, min: 0)).execute
    AvailabilityService::Create.new(fp_id: 'test_1', from: base.change(hour: 17, min: 30)).execute
  end

  it 'returns 2 availabilities' do
    at = base.change(day: 12, month: 10, year: 2020, hour: 11, min: 0)

    expect(AvailabilityService::SearchByTime.new(at: at).execute.count).to eq 2
  end

  it 'returns 0 availabilities' do
    at = base.change(day: 12, month: 10, year: 2020, hour: 17, min: 0)

    expect(AvailabilityService::SearchByTime.new(at: at).execute.count).to eq 0
  end
end
