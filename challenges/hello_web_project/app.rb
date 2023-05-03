require "sinatra/base"
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/hello" do
    return erb(:index)
  end

  get "/names" do
    return "Julia, Mary, Karim"
  end

  post "/sort-names" do
    names = params[:names]
    list_of_names = names.split(",")
    list_of_names.sort.join(",")
  end
end