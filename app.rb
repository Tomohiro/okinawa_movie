require 'rubygems'
require 'sinatra'
require 'haml'

require 'model/movie'

set :haml, { :format => :html5 }

get '/' do
  @startheaters = Movie.startheaters
  @sakurazaka   = Movie.sakurazaka

  haml :index
end

get '/showtime/:id' do |id|
  @movie = Movie[id]

  haml :showtime
end
