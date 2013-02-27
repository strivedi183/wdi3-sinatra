create table todo_list
(
  id serial8 primary key,
  task_title varchar(300),
  task_description text,
  date_created timestamp,
  due_date date,
  due_time time
)
