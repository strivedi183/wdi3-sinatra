require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  erb :home
end

post '/navigate' do
  case params[:destination].downcase
  when 'sports' then redirect to('/sports')
  when 'celebrity' then redirect to('/celebrity')
  when 'gossip' then redirect to('/gossip')
  when 'weather' then redirect to('/weather')
  end
end

get '/sports' do
  erb :sports
end

get '/celebrity' do
  erb :celebrity
end

get '/gossip' do
  erb :gossip
end

get '/weather' do
  erb :weather
end
