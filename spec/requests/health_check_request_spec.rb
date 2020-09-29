require 'rails_helper'

RSpec.describe "HealthChecks", type: :request do

  describe "GET /health" do
    it "returns status up" do
      get "/health"

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      got = JSON.parse(response.body, symbolize_names: true)
      expect(got[:status]).to eq("UP")
    end
  end

end
