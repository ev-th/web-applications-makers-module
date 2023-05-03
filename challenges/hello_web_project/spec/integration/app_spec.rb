require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /hello" do
    it "returns some html with hello message" do
      response = get("/hello")

      expect(response.status).to eq 200

      expect(response.body).to include "<h1>Hello!</h1>"
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

  context "POST /sort-names" do
    it "returns a sorted list of five names" do
      response = post("sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      expect(response.status). to eq 200

      expected_response = "Alice,Joe,Julia,Kieran,Zoe"
      expect(response.body).to eq expected_response
    end

    it "returns a sorted list of three names" do
      response = post("sort-names", names: "Alice,Bob,Charlie")

      expect(response.status). to eq 200

      expected_response = "Alice,Bob,Charlie"
      expect(response.body).to eq expected_response
    end
  end
end