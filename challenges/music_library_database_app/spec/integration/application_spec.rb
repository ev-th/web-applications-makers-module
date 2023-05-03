require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  before(:each) do
    reset_artists_table
    reset_albums_table
  end

  context "GET /albums" do
    it "returns all albums" do
      response = get("/albums")

      expect(response.status).to eq 200
      expect(response.body).to include("<div>\n      Title: Doolittle\n")
      expect(response.body).to include("Released: 1989")
      expect(response.body).to include("<div>\n      Title: Surfer Rosa")
      expect(response.body).to include("Released: 1988")
    end
  end

  context "POST /albums" do
    xit 'returns 200 OK and adds an album to the database' do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq(200)
      
      response = get("/albums")
      expect(response.body).to include "Voyage"
    end
  end
  
  context "GET /artists" do
    it "returns a list of artist names" do
      response = get("/artists")
      expect(response.status).to eq(200)
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
  end

  context "POST /artists" do
    it "returns 200 OK and adds an artist to the database" do
      response = post("/artists", name: "Wild Nothing", genre: "Indie")
      expect(response.status).to eq 200

      response = get("/artists")
      expect(response.body).to include "Wild Nothing"
    end
  end

  context "GET /albums/:id" do
    it "returns correct html for id 1" do
      response = get('/albums/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it "returns correct html for id 2" do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end
end