require 'rails_helper'

RSpec.describe AvailabilityService::Search, type: :model do
  context 'search by date' do
    from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)
    to = Time.current.change(day: 12, month: 10, year: 2020, hour: 17, min: 30)

    it 'returns 3 availabilities' do
      AvailabilityService::Create.new(fp_id: 'test_1', from: from.change(hour: 11, min: 0)).execute
      AvailabilityService::Create.new(fp_id: 'test_2', from: from.change(hour: 17, min: 0)).execute
      AvailabilityService::Create.new(fp_id: 'test_3', from: from.change(hour: 17, min: 30)).execute

      expect(AvailabilityService::Search.new(from: from, to: to).execute.count).to eq 3
    end

    it 'returns 0 availabilities' do
      expect(AvailabilityService::Search.new(from: from, to: to).execute.count).to eq 0
    end
  end

  context 'search by datetime' do
    base = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)

    before do
      AvailabilityService::Create.new(fp_id: 'test_1', from: base.change(hour: 11, min: 0)).execute
      AvailabilityService::Create.new(fp_id: 'test_2', from: base.change(hour: 11, min: 0)).execute
      AvailabilityService::Create.new(fp_id: 'test_1', from: base.change(hour: 17, min: 30)).execute
    end

    it 'returns 2 availabilities' do
      at = base.change(day: 12, month: 10, year: 2020, hour: 11, min: 0)

      expect(AvailabilityService::Search.new(at: at).execute.count).to eq 2
    end

    it 'returns 0 availabilities' do
      at = base.change(day: 12, month: 10, year: 2020, hour: 17, min: 0)

      expect(AvailabilityService::Search.new(at: at).execute.count).to eq 0
    end
  end
end
