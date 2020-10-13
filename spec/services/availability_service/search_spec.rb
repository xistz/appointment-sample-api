# require 'rails_helper'

# RSpec.describe AvailabilityService::List, type: :model do
#   from = Time.current.change(day: 12, month: 10, year: 2020, hour: 10, min: 0)
#   to = Time.current.change(day: 12, month: 10, year: 2020, hour: 17, min: 30)

#   it 'returns 2 availabilities' do
#     Availability.create(user_id: dummy_id, from: from.change(hour: 11, min: 0))
#     Availability.create(user_id: dummy_id, from: from.change(hour: 17, min: 0))
#     Availability.create(user_id: 'test_2', from: from.change(hour: 17, min: 0))

#     expect(AvailabilityService::Search.new(from: from, to: to).execute.count).to eq 2
#   end

#   it 'returns 0 availabilities' do
#     Availability.create(user_id: 'test_2', from: from.change(day: 12, month: 10, year: 2020, hour: 17, min: 0))

#     expect(AvailabilityService::Search.new(from: from, to: to).execute.count).to eq 0
#   end
# end
