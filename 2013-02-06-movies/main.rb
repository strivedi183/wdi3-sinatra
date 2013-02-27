require 'pry'
require 'httparty'
require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get "/movies" do
  sql = "select poster from movies"

  conn = PG.connect(:dbname => 'movies_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :posters
end

get "/" do
  erb :home
end

get "/about" do
  erb :about
end

post "/movie_search" do
  if params[:movie_title].present?
    @title = params[:movie_title].downcase.chomp.gsub(' ','+')
    @results = HTTParty.get("http://www.omdbapi.com/?i=&t=#{@title}")
    @results = JSON(@results.body)

    sql = "insert into movies (title, year, rated, released, runtime, genre, director, writer, actors, plot, poster, rating, votes, imdb_id) values ('#{results['Title']}', '#{results['Year']}', '#{results['Rated']}', '#{results['Released']}', '#{results['Runtime']}', '#{results['Genre']}', '#{results['Director']}', '#{results['Writer']}', '#{results['Actors']}', '#{results['Plot']}', '#{results['Poster']}', '#{results['imdbRating']}', '#{results['imdbVotes']}', '#{results['imdbID']}')"

    conn = PG.connect(:dbname =>'movies_app', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end
  erb :about
end
