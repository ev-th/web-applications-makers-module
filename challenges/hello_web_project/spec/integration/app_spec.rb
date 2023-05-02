require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /names" do
    it 'returns 200 OK' do
      response = get('/names')
      
      expect(response.status).to eq(200)

      expected_response = "Julia, Mary, Karim"
      expect(response.body).to eq(expected_response)
    end
  end
end