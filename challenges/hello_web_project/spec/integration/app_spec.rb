require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /hello" do
    it 'returns "Hello Evan"' do
      response = get("/hello", name: "Evan")

      expect(response.status).to eq 200

      expected_response = "Hello Evan"
      expect(response.body).to eq expected_response
    end

    it 'returns "Hello Alice"' do
      response = get("/hello", name: "Alice")

      expect(response.status).to eq 200

      expected_response = "Hello Alice"
      expect(response.body).to eq expected_response
    end
  end


  context "GET /names" do
    it 'returns 200 OK' do
      response = get('/names')

      expect(response.status).to eq(200)

      expected_response = "Julia, Mary, Karim"
      expect(response.body).to eq(expected_response)
    end
  end
end