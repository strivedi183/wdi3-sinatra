require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get "/" do
  erb :home
end

get "/add" do
  erb :add
end

get "/friends" do
  sql = "select * from friends"
  conn = PG.connect(:dbname => 'friends_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :friends
end

post "/create" do
  if params[:name].present?
    @name = params[:name]
    @age = params[:age]
    @gender = params[:gender]
    @image = params[:image]
    @twitter = params[:twitter]
    @facebook = params[:facebook]
    @github = params[:github]

    sql = "insert into friends (name, age, gender, image, twitter, facebook, github) values ('#{@name}', '#{@age}', '#{@gender}', '#{@image}', '#{@twitter}', '#{@facebook}', '#{@github}')"

    conn = PG.connect(:dbname =>'friends_app', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end
  redirect to("/")
end
