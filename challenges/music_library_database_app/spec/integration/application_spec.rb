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
      expect(response.body).to include("Title: <a href=\"/albums/1\">Doolittle</a>")
      expect(response.body).to include("Released: 1989")

      expect(response.body).to include("Title: <a href=\"/albums/2\">Surfer Rosa</a>")
      expect(response.body).to include("Released: 1988")
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

  context "POST /albums" do
    it 'adds an album to the database' do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")
      
      response = get("/albums")
      expect(response.body).to include "Voyage"
    end

    it 'returns 200 OK and success page' do
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq(200)
      expect(response.body).to include "<h1>Your album has been added!</h1>"
    end
  end

  context "GET /albums/new" do
    it "returns the form for adding a new album to the database" do
      response = get("/albums/new")

      expect(response.status).to eq 200
      
      expect(response.body).to include "<h1>Add a new album</h1>"
      expect(response.body).to include '<form action="/albums" method="POST">'
      expect(response.body).to include '<input type="text" name="title">'
      expect(response.body).to include '<input type="text" name="release_year">'
      expect(response.body).to include '<input type="text" name="artist_id">'
      expect(response.body).to include '<input type="submit">'
    end
  end
  
  context "GET /artists" do
    it "returns a list of artists as html" do
      response = get("/artists")
      expect(response.status).to eq(200)
      expect(response.body).to include "<h1>Artists</h1>"
      expect(response.body).to include '<p><a href="/artists/1">Pixies</a> - Rock</p>'
      expect(response.body).to include '<p><a href="/artists/2">ABBA</a> - Pop</p>'
      expect(response.body).to include '<p><a href="/artists/3">Taylor Swift</a> - Pop</p>'
      expect(response.body).to include '<p><a href="/artists/4">Nina Simone</a> - Pop</p>'
    end
  end
  
  context "GET /artists/new" do
    it "returns an html form to enter a new artist to the database" do
      response = get("/artists/new")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Add a new artist</h1>"
      expect(response.body).to include '<form action="/artists" method="POST">'
      expect(response.body).to include '<input type="text" name="name">'
      expect(response.body).to include '<input type="text" name="genre">'
      expect(response.body).to include '<input type="submit">'
    end
  end
  
  context "GET /artists/:id" do
    it "returns html with details of a single artist" do
      response = get("/artists/1")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Pixies</h1>"
      expect(response.body).to include "<p>Rock</p>"
    end

    it "returns html with details of another artist" do
      response = get("/artists/2")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>ABBA</h1>"
      expect(response.body).to include "<p>Pop</p>"
    end
  end

  context "POST /artists" do
    it "adds an artist to the database" do
      response = post("/artists", name: "Wild Nothing", genre: "Indie")
      response = get("/artists")
      expect(response.body).to include "Wild Nothing"
    end
    
    it "returns 200 OK and an html success page" do
      response = post("/artists", name: "Wild Nothing", genre: "Indie")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Your artist has been added!</h1>"
    end
  end
end
