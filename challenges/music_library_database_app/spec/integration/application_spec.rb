require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /albums" do
    it "returns all albums" do
      response = get("/albums")

      expect(response.status).to eq 200
      expect(response.body).to eq(
        "Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore" +
        ", I Put a Spell on You, Baltimore, Here Comes the Sun" +
        ", Fodder on My Wings, Ring Ring"
      )
    end
  end

  context "POST /albums" do
    it 'returns 200 OK and adds an artist to the database' do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq(200)

      response = get("/albums")
      expect(response.body).to include "Voyage"
    end
  end

  # context "GET /artists" do
  #   it "returns "
end