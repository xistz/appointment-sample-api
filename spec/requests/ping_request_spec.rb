# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ping', type: :request do
  describe 'GET /ping' do
    it 'returns status ok' do
      get '/ping'

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      got = JSON.parse(response.body, symbolize_names: true)
      expect(got[:message]).to eq('pong')
    end
  end
end
