require "sinatra/base"
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/hello" do
    name = params[:name]
    return "Hello #{name}"
  end
end