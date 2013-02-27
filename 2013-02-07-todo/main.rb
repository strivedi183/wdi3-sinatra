require 'pry'
require 'httparty'
require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get "/" do
  sql = "select * from todo_list"
  conn = PG.connect(:dbname => 'todo_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :home
end

get "/todo" do
  erb :todo
end

get "/new" do
  erb :new
end

post "/create" do
  if params[:task_title].present?
    @task_title = params[:task_title]
    @task_description = params[:task_description]

    sql = "insert into todo_list (task_title, task_description) values ('#{@task_title}', '#{@task_description}')"

    conn = PG.connect(:dbname =>'todo_app', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end
  redirect to("/")
end