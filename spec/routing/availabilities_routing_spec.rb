require 'rails_helper'

RSpec.describe AvailabilitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/availabilities').to route_to('availabilities#index')
    end

    it 'routes to #create' do
      expect(post: '/availabilities').to route_to('availabilities#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/availabilities/1').to route_to('availabilities#destroy', id: '1')
    end

    it 'routes to #search' do
      expect(get: '/availabilities/search').to route_to('availabilities#search')
    end
  end
end
