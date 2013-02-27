require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

before do
  sql = "select distinct genre from memetubes"
  @nav_rows = run_sql(sql)
end

get '/' do
  erb :home
end

get '/new' do
  sql = "select distinct genre from memetubes"
  @form_rows = run_sql(sql)
  erb :new
end

get '/videos' do
  sql = "select * from memetubes"
  @rows = run_sql(sql)
  erb :videos
end

post '/create' do
  sql = "insert into memetubes (title, description, url, genre) values ('#{params['title']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
  run_sql(sql)
  redirect to('/videos')
end

get '/videos/:genre' do
  sql = "select * from memetubes where genre = '#{params['genre']}'";
  @rows = run_sql(sql)
  erb :videos
end

post '/videos/:memetubes_id' do
  sql = "update memetubes set title='#{params['title']}', description='#{params['description']}', url='#{params['url']}', genre='#{params['genre']}' where id = #{params['memetubes_id']}"
  run_sql(sql)
  redirect to('/videos')
end

get '/videos/:memetubes_id/edit/' do
  sql = "select * from memetubes where id = #{params['memetubes_id']}"
  rows = run_sql(sql)
  @row = rows.first
  erb :new
end

post '/videos/:memetubes_id/delete' do
  sql = "delete from memetubes where id = #{params['memetubes_id']}"
  run_sql(sql)
  redirect to('/videos')
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'memetube_app', :host => 'localhost')
  result = conn.exec(sql)
  conn.close
  result
end
