create table movies
(
  id serial8 primary key,
  title varchar(250),
  year varchar(250),
  rated varchar(250),
  released varchar(250),
  runtime varchar(250),
  genre varchar(250),
  director varchar(250),
  writer varchar(250),
  actors varchar(250),
  plot text,
  poster text,
  rating varchar(250),
  votes varchar(250),
  imdb_id varchar(250)
);
